import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailc = TextEditingController();
  TextEditingController passc = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async{
    // print("LOGIN");
    if (emailc.text.isNotEmpty && passc.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailc.text,
          password: passc.text,
        );

        print(userCredential);
        
        if (userCredential.user!= null) {
          
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passc.text == "presensipkl123") {
              Get.offAllNamed(Routes.PASSWORD_BARU);
            } else{
              Get.offAllNamed(Routes.HOME);
            } 

          }else{

            Get.defaultDialog(
              title: "Email anda belum terverifikasi.",
              middleText: "Silahkan verifikasi akun email anda terlebih dahulu",
              actions: [
                OutlinedButton(
                  onPressed: (){
                    isLoading.value = false;
                    Get.back();
                  },
                  child: const Text("BATAL"),
                ),
                ElevatedButton(
                  onPressed: () async{
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar("Berhasil", "Berhasil mengirim email verifikasi.");
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar("Ada Kesalahan", "Tidak dapat mengirim email verifikasi.");
                    }
                    
                  }, 
                  child: const Text("KIRIM ULANG"))
              ],
            );
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar("Ada Kesalahan", "Email tidak terdaftar");
        } else if (e.code == 'wrong-password') {
           Get.snackbar("Ada Kesalahan", "Password salah");
        }
      } catch (e){
        isLoading.value = false;
        Get.snackbar("Ada Kesalahan", "Tidak dapat login");
      }
    }else{
      Get.snackbar("Ada Kesalahan", "Email dan Password harap diisi");
    }
  }
}
