import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';

import '../controllers/password_baru_controller.dart';

class PasswordBaruView extends GetView<PasswordBaruController> {
  const PasswordBaruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: tPrimaryColor,
        title: const Text("PASSWORD BARU",
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
          autocorrect: false,
            controller: controller.barupass,
            obscureText : true,
            decoration: const InputDecoration(
              label: Text("Password Baru"), 
              ),
          ),

        const SizedBox(height: tFormHeight),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              controller.passwordbaru();
            },
            child: Text(
              "PASSWORD BARU".toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
          ),
        )

       ],
      )
    );
  }
}
