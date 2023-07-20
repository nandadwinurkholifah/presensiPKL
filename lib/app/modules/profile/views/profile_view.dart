import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const 
        Text("Profile",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
        )
        ),
        centerTitle: false,
      ),
      body: Container(

        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic >>>(
          stream: controller.streamUser(),
          builder: (context,snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;
              String defaultimage = "https://ui-avatars.com/api/?nama=${user['nama']}";
              return ListView(
                children: [
                  Column(
                    children: [
                        Container (
                          width: double.infinity,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: tPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(tPadding),
                              bottomLeft: Radius.circular(tPadding),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Padding(padding: EdgeInsets.all(tDefaultSize -5)),
                              ClipOval(
                                child:
                                   SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: 
                                    Image.network(
                                    user["profile"] !=null 
                                      ? user["profile"] != "" 
                                        ? user["profile"] 
                                      : defaultimage
                                      : defaultimage,
                                      fit: BoxFit.cover,
                                    ),
                                    
                                  ),
                              ),

                              const SizedBox(width: tFormHeight,),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                
                                children: [  
                                   Container(
                                      // padding: const EdgeInsets.only(left: 0, top: 1),
                                      width: 150,
                                      height: 60,
                                      child: Flexible(
                                        child: Text(
                                          user['nama_lengkap'].toString().toUpperCase(),
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w700,
                                            color: tWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),

                                  const SizedBox(height: 5),
                                  
                                  Text(user['email'],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: tWhiteColor),
                                  )
                                ],
                              ), 
                            ],
                          ), 
                          
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [                     
                      Container(
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                // if (user['role'] == 'mahasiswa') {
                                  // Pengguna dengan peran mahasiswa
                                  Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                                // } else if (user['role'] == 'admin') {
                                  // Pengguna dengan peran admin
                                  // Get.toNamed(Routes.UPDATE_PROFILE_ADMIN, arguments: user);
                                // } else{
                                  // Get.toNamed(Routes.UPDATE_PROFILE_PMB, arguments: user);
                                // }
                              },
                              leading: const Icon(Icons.person_outline_outlined, color: tPrimaryColor),
                              title: const Text("Update Profile"),
                            ),
                            const SizedBox(height: 5),

                            ListTile(
                              onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD) ,
                              leading: const Icon(Icons.key_outlined, color: tPrimaryColor,),
                              title: const Text("Update Password"),
                            ),
                          ],
                        ),
                      )
                    ],
                    
                  )
                ],
              );
            } else{
              return const Center(
                child: Text("Tidak Dapat Menampilkan User"),
              );
            }
          },
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
