import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
 RxBool isLoading = false.obs;
  TextEditingController lamc = TextEditingController();
  TextEditingController barc = TextEditingController();
  TextEditingController komc = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatepassword() async {
    if (lamc.text.isNotEmpty && barc.text.isNotEmpty && komc.text.isNotEmpty) {
      if (barc.text == komc.text) {
        isLoading.value = true;
        try {
          String emailuser = auth.currentUser!.email!;

          await auth.signInWithEmailAndPassword(email: emailuser, password: lamc.text);

          await auth.currentUser!.updatePassword(barc.text);

          Get.back();

          Get.snackbar("Berhasil", "Berhasil Mengupdate Password");
          
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
          Get.snackbar("Ada Kesalahan", "Password Lama Salah"); 
          } else{
            Get.snackbar("Ada Kesalahan", e.code.toLowerCase()); 
          }
        } catch (e) {
          Get.snackbar("Ada Kesalahan", "Tidak Dapat Mengupdate Password");
        } finally{
          isLoading.value = false;
        }
        
      } else{
        Get.snackbar("Ada Kesalahan", "Konfirmasi Password Tidak Cocok");
      }
    } else{
      Get.snackbar("Ada Kesalahan", "Semua Inputan Harus Diisi.");
    }
  }
}
