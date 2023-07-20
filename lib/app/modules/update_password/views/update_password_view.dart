import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("UPDATE PASSWORD",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),
      body: ListView(
       padding: const EdgeInsets.all(tDefaultSize),
       children: [
        TextFormField(
          controller:  controller.lamc,
          autocorrect: false,
            obscureText : true,
            decoration: const InputDecoration(
              label: Text("Password Lama"), 
            ),
        ),

        const SizedBox(height: tDefaultSize,),

        TextFormField(
          controller:  controller.barc,
          autocorrect: false,
            obscureText : true,
            decoration: const InputDecoration(
              label: Text("Password Baru"), 
            ),
        ),

        const SizedBox(height: tDefaultSize,),

        TextFormField(
          controller: controller.komc,
          autocorrect: false,
            obscureText : true,
            decoration: const InputDecoration(
              label: Text("Konfirmasi Password Baru"), 
            ),
        ),

        const SizedBox(height: tDefaultSize,),

        Obx(
          () => ElevatedButton(
            onPressed: () {
              if (controller.isLoading.isFalse) {
                controller.updatepassword();
              }
          },
           child: Text((controller.isLoading.isFalse) ? "GANTI PASSWORD" : "LOADING..."),),
        ),
      ]
    )
    );
  }
}
