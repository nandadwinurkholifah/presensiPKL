import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("Profile",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton:  Obx(
        () => FloatingActionButton(
        onPressed: () async {
          if (controller.isLoading.isFalse) {
            controller.isLoading.value = true;
            await FirebaseAuth.instance.signOut();
            controller.isLoading.value = false ;
            Get.offAllNamed(Routes.LOGIN);
          }
        },
        backgroundColor: tPrimaryColor,
        child: controller.isLoading.isFalse ? const Icon(Icons.logout) :const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
