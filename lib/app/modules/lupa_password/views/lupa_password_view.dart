import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("LUPA PASSWORD",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         // Theme.of(context).textTheme.headline2,
         )
        ),
        centerTitle: false,
      ),
      body: ListView(
       padding: const EdgeInsets.all(tDefaultSize),
       children: [

        TextFormField(
          autocorrect: false,
            controller: controller.emailc,
            decoration: const InputDecoration(
              label: Text("Email"), 
              ),
          ),

        const SizedBox(height: tFormHeight),

        Obx(() => ElevatedButton(
          onPressed: () async {
            if (controller.isLoading.isFalse) {
               await controller.sendEmail();
            }
          },
          child: Text(controller.isLoading.isFalse? "KIRIM RESET PASSWORD " : "LOADING...",
          ),
          ),
        ),

       ],
      )
    );
  }
}
