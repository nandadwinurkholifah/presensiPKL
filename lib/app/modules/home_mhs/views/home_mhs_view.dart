import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/home_mhs_controller.dart';

class HomeMhsView extends GetView<HomeMhsController> {
  const HomeMhsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text(tAppName,
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),

      bottomNavigationBar: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamrole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          String roles = snapshot.data?.data()?["role"] ?? "";
          bool isAdminOrMahasiswa = roles == "admin" || roles == "mahasiswa";

          return ConvexAppBar(
            style: TabStyle.react,
            backgroundColor: tPrimaryColor,
            height: 50,
            top: -20,
            curveSize: 100,
            items: [
              const TabItem(icon: Icons.home, title: 'Home'),

              if (isAdminOrMahasiswa)
                TabItem(
                  icon: SvgPicture.asset(
                    'assets/icons/task_complete.svg',
                    width: 1,
                    height: 1,
                    color: const Color(0xFFA1C1B6),
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/task_complete.svg',
                    width: 1,
                    height: 1,
                  ),
                  title: 'Presensi',
                ),

              const TabItem(icon: Icons.person, title: 'Profile'),
            ],
            initialActiveIndex: controller.pageIndex.value,
            onTap: (int index) => controller.changePage(index),
          );
        },
      ),
      
      body: GridView.count(
      padding: const EdgeInsets.all(tDefaultSize), 
      crossAxisCount: 2,
      children: <Widget>[
          Card(
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: tPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () 
              => Get.toNamed(Routes.ADD_PEMBIMBING),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: const <Widget>[
                    Icon(
                      Icons.person,
                      color: tPrimaryColor,
                      size: 65,
                    ),
                    SizedBox(height: 5), 
                    Padding(
                    padding: EdgeInsets.all(5.0), // Tambahkan padding di sini
                    child: Text(
                      "Presensi Mahasiswa",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: tPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
