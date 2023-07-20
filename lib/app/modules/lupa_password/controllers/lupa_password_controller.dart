import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LupaPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailc = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailc.text.isNotEmpty){
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailc.text);
        Get.back();
        Get.snackbar("Berhasil", "Berhasil mengirim email reset password");
    } catch (e) {
      Get.snackbar("Ada Kesalahan", "Tidak Dapat Mengirim Email Reset Password");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
