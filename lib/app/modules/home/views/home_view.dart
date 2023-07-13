import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/routes/app_pages.dart';
import '../../pengenal_wajah/controllers/pengenal_wajah_controller.dart';
import '../controllers/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  // final PengenalWajahController wajahController = Get.put(PengenalWajahController());
  // final pageC = Get.put(HomeController(), permanent: true);
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
          ..._buildCard(Routes.ADD_MAHASISWA, Icons.person_add, 'Tambah Mahasiswa', ['admin']),
          ..._buildCard(Routes.ADD_PEMBIMBING, Icons.people, 'Tambah Pembimbing', ['admin']),
          // ..._buildCard(Routes.PRESENSI_GURU, 'assets/icons/task_deadline.svg', 'Presensi Guru', ['Guru Piket', 'Admin']),
          // ..._buildCard(Routes.ADD_GURU, Icons.person_add_alt_1_rounded, 'Tambah Pegawai', ['Admin']),
          // ..._buildCard(Routes.REKAP_GURU, 'assets/icons/task_deadline.svg', 'Rekap Absensi Guru', ['Admin']),
          // ..._buildCard(Routes.ADD_MATA_PELAJARAN, Icons.menu_book_outlined, 'Tambah Mata Pelajaran',
          //     ['Guru', 'Admin']),
        ],
      ),
    );
  }

  List<Widget> _buildCard(String route, dynamic icon, String text, List<String> allowedRoles) {
    return [
      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamrole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          String role = snapshot.data!.data()!["role"];
          if (allowedRoles.contains(role)) {
            return Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: tPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () => Get.toNamed(route),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (icon is IconData)
                          Icon(
                            icon,
                            color: tPrimaryColor,
                            size: 65,
                          )
                        else if (icon is String)
                          SvgPicture.asset(
                            icon,
                            width: 65,
                            height: 65,
                            color: tPrimaryColor,
                          ),
                        Text(
                          text,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: tPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    ];
  }
}