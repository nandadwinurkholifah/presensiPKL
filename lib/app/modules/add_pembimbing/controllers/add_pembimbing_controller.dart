import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPembimbingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingAddmhs = false.obs;
  TextEditingController nidnc = TextEditingController();
  TextEditingController namapc = TextEditingController();
  TextEditingController emailpc = TextEditingController();
  TextEditingController passadmin = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> prosesAddpmb() async{
    if (passadmin.text.isNotEmpty) {
      isLoadingAddmhs.value = true;
      try {
        String emailadmin = auth.currentUser!.email!;
          
        UserCredential userCredentialAdmin = await auth.signInWithEmailAndPassword(
        email: emailadmin, 
        password: passadmin.text,
        );

        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: emailpc.text,
          password: "presensipkl123"
        );  
    
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          await firestore.collection("users").doc(uid).set({
            "nidn" : nidnc.text,
            "nama_lengkap" : namapc.text,
            "email" : emailpc.text,
            "uid" : uid,
            "role": "pembimbing",
            "create_at" : DateTime.now().toIso8601String(),
          });

          await userCredential.user!.sendEmailVerification();

          // CollectionReference<Map<String, dynamic>> mhsCollection =
          // firestore.collection("pembimbing");

          // await firestore.collection("pembimbing").doc(uid).set({
          //   "nim" : nidnc.text,
          //   "nama_lengkap" : namapc.text,
          //   "email" : emailpc.text,
          //   "uid" : uid,
          //   "create_at" : DateTime.now().toIso8601String(),
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

  Future<void> Addpmb() async {
    if (nidnc.text.isNotEmpty && namapc.text.isNotEmpty && emailpc.text.isNotEmpty) {
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
                      await prosesAddpmb();
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
