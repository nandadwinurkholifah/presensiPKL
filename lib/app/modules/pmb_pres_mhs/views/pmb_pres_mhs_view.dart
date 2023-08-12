import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/modules/detail_presensi/controllers/detail_presensi_controller.dart';

import '../../detail_presensi/views/detail_presensi_view.dart';
import '../controllers/pmb_pres_mhs_controller.dart';

class PmbPresMhsView extends GetView<PmbPresMhsController> {
  const PmbPresMhsView({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
     final detailPresensiController = Get.put(DetailPresensiController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text(
          "Presensi Mahasiswa",
          style: TextStyle(
            color: tWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<List<String>>(
        stream: controller.streampres_pmb(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error in retrieving data"),
            );
          }
          List<String>? namaLengkapList = snapshot.data;
          if (namaLengkapList == null || namaLengkapList.isEmpty) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: Text("Belum Ada Data Presensi"),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: namaLengkapList.length,
            itemBuilder: (context, index) {
              String namaLengkap = namaLengkapList[index];
              return ListTile(
                title: Text(
                  namaLengkap,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Navigasi ke halaman detail presensi dengan parameter nama lengkap
                  Get.to(() => DetailPresensiView(namaLengkap: namaLengkap));
                },
              );
            },
          );
        },
      ),
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:presensi/app/constants/colors.dart';
// import 'package:presensi/app/modules/detail_presensi/controllers/detail_presensi_controller.dart';

// import '../../detail_presensi/views/detail_presensi_view.dart';
// import '../controllers/pmb_pres_mhs_controller.dart';

// class PmbPresMhsView extends GetView<PmbPresMhsController> {
//   const PmbPresMhsView({Key? key}) : super(key: key);

//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: tPrimaryColor,
//         title: const Text(
//           "Presensi Mahasiswa",
//           style: TextStyle(
//             color: tWhiteColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           ListTile(
//             title: Text(
//               "Abdul Khamid", // Ganti dengan teks dari database sesuai kebutuhan
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 1"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Adi Surya Jinggo", // Ganti dengan teks dari database sesuai kebutuhan
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 2"));
//             },
//           ),
//           // Tambahkan ListTile sesuai jumlah data dari database
//           // Contoh: 
//           ListTile(
//             title: Text(
//               "Ananto Indra Nugraha",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Arief Krisnah Sholikhan",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Billy Coster Junior",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Desi Yunitasari",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Diki Candra",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Fera Yuliana",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Gatra Cahya Ramadhan",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Ilmy Rahmawaty",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "M. Irfan Hanafi",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Maulana Ardillan Arendra",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Moh. Alfian Nugroho",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Muhammad Rosyan Amanullah",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Nanda Dwi Nurkholifah",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Pratama Bagus Wibisono",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),
//           ListTile(
//             title: Text(
//               "Ananto Indra Nugraha",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             onTap: () {
//               // Navigasi ke halaman detail presensi dengan parameter nama lengkap
//               // Get.to(() => DetailPresensiView(namaLengkap: "Budak 3"));
//             },
//           ),

//         ],
//       ),
//     );
//   }

// }

