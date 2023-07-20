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

