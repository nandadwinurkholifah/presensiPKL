import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';

class PasswordBaruController extends GetxController {

  TextEditingController barupass = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void passwordbaru() async {
    if (barupass.text.isNotEmpty) {
      if (barupass.text != "presensipkl123") {  
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(barupass.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email, 
            password: barupass.text,
          );

          Get.offAllNamed(Routes.HOME);

        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
          Get.snackbar("Ada Kesalahan", "Password terlalu mudah, setidaknya 6 karakter");
        } 
        } catch (e){
          Get.snackbar("Ada Kesalahan", "Tidak dapat membuat password baru");
        }
        
      } else{
        Get.snackbar("Ada Kesalahan", "Password harus diubah");
      }
    } else{
      Get.snackbar("Ada Kesalahan", "Password baru wajib diisi");
    }
  }
}
