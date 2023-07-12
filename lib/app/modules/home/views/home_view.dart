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

      // body: SingleChildScrollView(
      //   child: Container(
      //     padding:  const EdgeInsets.all(tDefaultSize),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children:  [
      //           SizedBox(
      //             width: double.infinity,
      //             child: ElevatedButton(
      //               onPressed: () async {
      //                 // wajahController.ambilgambar();
      //                 // final photo = wajahController.photo.value;
      //                 // if (photo != null) {
      //                 //   Get.toNamed(Routes.PENGENAL_WAJAH, arguments: photo);
      //                 // }
      //               },
      //               child: const Text("AMBIL GAMBAR"),
      //             ),
      //           ),
      //           const SizedBox(height: 10),
      //           // SizedBox(
      //           //   width: double.infinity,
      //           //   child: ElevatedButton(
      //           //     onPressed: ()  {
      //           //        final photo = wajahController.photo.value;
      //           //         if (photo != null) {
      //           //           Get.toNamed(Routes.PENGENAL_WAJAH, arguments: photo);
      //           //         }
      //           //     },
      //           //     child: const Text("WAJAH"),
      //           //   ),
      //           // ),
      //         ]
      //       )
      //   ),
      // )

      body: GridView.count(
      padding: const EdgeInsets.all(tDefaultSize), 
      crossAxisCount: 2,
      children: <Widget>[
        // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        // stream: controller.streamrole(),
        // builder: (context, snapshot) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return const SizedBox();
        //   }

        //   String? role = snapshot.data?.data()?["role"];
        //   if (role == "admin") {
        //     return

              Card(
              margin: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: tPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(20.0),
                ),
                  child: InkWell(
                    onTap: () => Get.offAllNamed(Routes.ADD_MAHASISWA),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.person_add,
                            color: tPrimaryColor,
                            size: 65,
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.all(5.0), // Tambahkan padding di sini
                            child: Text(
                              "Tambah Mahasiswa",
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
                      => Get.offAllNamed(Routes.ADD_PEMBIMBING),
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
                              "Tambah Pembimbing",
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

                // } else if(role == "mahasiswa") {
                //   return
                //   Card(
                //     margin: const EdgeInsets.all(8),
                //     shape: RoundedRectangleBorder(
                //       side: const BorderSide(
                //         color: tPrimaryColor,
                //       ),
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     child: InkWell(
                //       onTap: () {},
                //       // => Get.toNamed(Routes.ADD_MATA_PELAJARAN),
                //       child: Center(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center, // Menambahkan alignment
                //           children: const <Widget>[
                //             Icon(
                //               Icons.menu_book_outlined,
                //               color: tPrimaryColor,
                //               size: 65,
                //             ),
                //             SizedBox(height: 10), // Menambahkan jarak antara ikon dan teks
                //             Text(
                //               "Mahasiswa",
                //               style: TextStyle(
                //                 fontSize: 15.0,
                //                 color: tPrimaryColor,
                //               ),
                //               textAlign: TextAlign.center, // Teks menjadi berada di tengah
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ); 
                // } else {
                //   return
                //   Card(
                //     margin: const EdgeInsets.all(8),
                //     shape: RoundedRectangleBorder(
                //       side: const BorderSide(
                //         color: tPrimaryColor,
                //       ),
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     child: InkWell(
                //       onTap: () {},
                //       // => Get.toNamed(Routes.ADD_MATA_PELAJARAN),
                //       child: Center(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center, // Menambahkan alignment
                //           children: const <Widget>[
                //             Icon(
                //               Icons.menu_book_outlined,
                //               color: tPrimaryColor,
                //               size: 65,
                //             ),
                //             SizedBox(height: 10), // Menambahkan jarak antara ikon dan teks
                //             Text(
                //               "Pembimbing",
                //               style: TextStyle(
                //                 fontSize: 15.0,
                //                 color: tPrimaryColor,
                //               ),
                //               textAlign: TextAlign.center, // Teks menjadi berada di tengah
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   );
            //     }
            //   },
            // ),
        ],
      ),
    );
  }
}
