import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfileController extends GetxController {
 RxBool isLoading = false.obs;
  TextEditingController emailc = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();
  XFile? image;

  void pilihgambar() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image!.name);
      print(image!.name.split(".").last);
      print(image!.path);
    } else {
      print(image);
    }
    update();
  }

  // Future<void> updateprofile(String uid) async {
  //   if (emailc.text.isNotEmpty ) {
  //     isLoading.value = true;
  //     try {
  //       Map<String, dynamic> data = {
  //         "email": emailc.text
  //       };

  //       if (image != null) {
  //         // Unggah image
  //         File file = File(image!.path);
  //         String ext = image!.name.split(".").last;

  //         firebase_storage.UploadTask uploadTask = storage
  //             .ref('$uid/profile.$ext')
  //             .putFile(file);

  //         firebase_storage.TaskSnapshot taskSnapshot =
  //             await uploadTask.whenComplete(() => null);

  //         String urlimage = await taskSnapshot.ref.getDownloadURL();

  //         data.addAll({"profile": urlimage});
  //       }

  //       await firestore.collection("users").doc(uid).update(data);

  //         // Mengganti email pada Firebase Authentication
  //       await auth.currentUser!.updateEmail(emailc.text);

  //       // Kirim verifikasi email baru
  //       await auth.currentUser!.sendEmailVerification();

  //       Get.back();
  //       Get.snackbar("Berhasil", "Berhasil Mengupdate Profile.");
  //     } catch (e) {
  //       Get.snackbar("Ada Kesalahan", "Tidak Dapat Mengupdate Profile.");
  //     } finally {
  //       isLoading.value = false;
  //     }
  //   }
  // }
  
  Future<void> updateprofile(String uid) async {
  if (emailc.text.isNotEmpty ) {
    isLoading.value = true;
    try {
      Map<String, dynamic> data = {
        "email": emailc.text
      };

      if (image != null) {
        // Unggah image
        File file = File(image!.path);
        String ext = image!.name.split(".").last;

        firebase_storage.UploadTask uploadTask = storage
            .ref('$uid/profile.$ext')
            .putFile(file);

        firebase_storage.TaskSnapshot taskSnapshot =
            await uploadTask.whenComplete(() => null);

        String urlimage = await taskSnapshot.ref.getDownloadURL();

        data.addAll({"profile": urlimage});
      }

      // Ambil email asli dari Firebase
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await firestore.collection("users").doc(uid).get();
      String originalEmail = userSnapshot.data()?['email'] ?? '';

      if (emailc.text != originalEmail) {
        // Jika email berubah, maka lakukan update email dan kirim verifikasi
        await auth.currentUser!.updateEmail(emailc.text);
        await auth.currentUser!.sendEmailVerification();
      }

      await firestore.collection("users").doc(uid).update(data);

      Get.back();
      Get.snackbar("Berhasil", "Berhasil Mengupdate Profile.");
    } catch (e) {
      Get.snackbar("Ada Kesalahan", "Tidak Dapat Mengupdate Profile.");
    } finally {
      isLoading.value = false;
    }
  }
}

}
