import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class AddMahasiswaController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddmhs = false.obs;
  TextEditingController nimc = TextEditingController();
  TextEditingController namac = TextEditingController();
  TextEditingController alamatc = TextEditingController();
  RxString jenkel = "".obs;
  RxString role = "".obs;
  TextEditingController emailc = TextEditingController();
  TextEditingController passadmin = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> prosesAddmhs() async{
    if (passadmin.text.isNotEmpty) {
      isLoadingAddmhs.value = true;
      try {
        String emailadmin = auth.currentUser!.email!;
          
        UserCredential userCredentialAdmin = await auth.signInWithEmailAndPassword(
        email: emailadmin, 
        password: passadmin.text,
        );

        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailc.text,
          password: "presensipkl123"
        );  

        

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await userCredential.user!.sendEmailVerification();
          List<Location> locations = await locationFromAddress(alamatc.text);
          await firestore.collection("users").doc(uid).set({
            "nim" : nimc.text,
            "nama_lengkap" : namac.text,
            "email" : emailc.text,
            // "uid" : uid,
            "jenis_kelamin" : jenkel.string,
            "alamat_pkl": {
              "lat": locations.last.latitude,
              "long": locations.last.longitude,
              "ket": alamatc.text,
            },
            "role": "mahasiswa",
            "create_at" : DateTime.now().toIso8601String(),
          });

          
          //ini bisa
          // await userCredential.user?.sendEmailVerification();

          
          // CollectionReference<Map<String, dynamic>> mhsCollection =
          // firestore.collection("mahasiswa");

          // await firestore.collection("mahasiswa").doc(uid).set({
            
          //   "nama_lengkap" : namac.text,
           
          //   "email" : emailc.text,
          //   "uid" : uid,
            
          //   // "role": role.string,
          //   "created_at" : DateTime.now().toIso8601String(),
          // });


          await auth.signOut();

          UserCredential userCredentialStaff = await auth.signInWithEmailAndPassword(
          email: emailadmin, 
          password: passadmin.text,
          );

          Get.back(); //tutup dialog
          Get.back(); //kembali ke beranda
          Get.snackbar("Berhasil", "Berhasil Menambah Guru, Silahkan Verifikasi Email");
        }
          // print(userCredential);
          isLoadingAddmhs.value = false;
      } on FirebaseAuthException catch (e) {
          isLoadingAddmhs.value = false;
          if (e.code == 'weak-password') {
              Get.snackbar("Ada Kesalahan", "Password yang digunakan terlalu mudah");
          } else if (e.code == 'email-already-in-use') {
              Get.snackbar("Ada Kesalahan", "Email yang dipakai sudah digunakan, Silahkan gunakan akun email lainnya");
          } else if (e.code == 'wrong-password') {
              Get.snackbar("Ada Kesalahan", "Validasi Staff Tidak Dapat Dilakukan. Password Salah!");
          } else{
            Get.snackbar("Ada Kesalahan", "${e.code}");
          }
        } catch (e) {
          isLoadingAddmhs.value = false;
          Get.snackbar("Ada Kesalahan", "Tidak Dapat Menambah Pegawai");
        }
    } else{
      isLoading.value = false;
      Get.snackbar("Ada Kesalahan", "Password Wajib Diisi");
    }
    
  }

  Future<void> Addmhs() async {
    if (namac.text.isNotEmpty && nimc.text.isNotEmpty && emailc.text.isNotEmpty) {
      isLoading.value = true;
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            const Text("Masukkan Password Untuk Validasi"),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              controller: passadmin,
              obscureText: true,
              decoration: const InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
              border: OutlineInputBorder(),
              
              ),
            ),
          ],
        ),
        actions: [
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children:[
              OutlinedButton(
                onPressed: () {
                  isLoading.value = false;
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(10), // Tambahkan padding di setiap sisi tombol
                ),
                child: const Text("KEMBALI"),
              ),
              const SizedBox(width: 10,),
              Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    if (isLoadingAddmhs.isFalse) {
                      await prosesAddmhs();
                    }
                    isLoading.value = false;
                  },
                  style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10), // Tambahkan padding di setiap sisi tombol
                  ), 
                  child: Text(isLoadingAddmhs.isFalse ? "TAMBAH MAHASISWA" : "LOADING..."),
                ),      
              ),
            ],
          ),
          ),
        ],

      );

    }
      else{
        Get.snackbar("Ada Kesalahan", "NIP, Nama, Jenis Kelamin, E-mail Wajib Diisi");
      }

  }
}
