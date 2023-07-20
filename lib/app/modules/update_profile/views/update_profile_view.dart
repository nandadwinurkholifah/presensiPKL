import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  final Map<String, dynamic> user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.emailc.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("Update Profile",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Container(
            padding:  const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [

                //email
                Text(tEmail, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                TextFormField(
                  autocorrect: false,
                  controller: controller.emailc,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined)),
                ),

                const SizedBox(height: tFormHeight),

                Text("Photo Profile", style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: tDefaultSize - 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<UpdateProfileController>(
                      builder: (c) {
                        if (c.image != null) {
                          return ClipOval(
                            child: Container(
                              width: 100,
                              height: 100,
                              child: Image.file(File(c.image!.path), fit: BoxFit.cover,),
                            ),
                          );
                          
                        } else{
                          if (user["profile"] != null) {
                            return ClipOval(
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                  user["profile"], 
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else{
                            return Text("gambar tidak ada");
                          }
                        }
                      },
                    ),
                    
                    TextButton(
                      onPressed: (){
                        controller.pilihgambar();
                      }, 
                      child: const Text("pilih"),
                      )
                  ],
                ),
                const SizedBox(height: tFormHeight),

                SizedBox(
                  width: double.infinity,
                  child:

                  Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.updateprofile(user["uid"]);
                      }
                    },
                    child: Text(controller.isLoading.isFalse? "UPDATE PROFILE" : "LOADING...",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
