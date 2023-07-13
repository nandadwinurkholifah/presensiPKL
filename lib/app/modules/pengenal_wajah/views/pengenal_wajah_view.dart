import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/modules/pengenal_wajah/controllers/pengenal_wajah_controller.dart';

import '../../home/controllers/home_controller.dart';

class PengenalWajahView extends GetView<PengenalWajahController> {
  const PengenalWajahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final XFile? photo = Get.arguments as XFile?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absensi'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: const Text("ABSENSI"),
              //   ),
              // ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    if (photo != null)
                      Image.file(
                        File(photo.path),
                        width: 400,
                        height: 300,
                      )
                    else
                    const Text('Belum ada gambar'),
                    const SizedBox(height: 10),
                    // Text("Nama: ${controller.nama.value}"),
                    Text("Nama: ${controller.nama.value != 'Tidak terdeteksi' ? controller.nama.value : 'Belum terdeteksi'}"),
                    Text("Confidence: ${controller.confidencePercent.value}"),
                  ],
                ),
              ),

              const SizedBox(height: tFormHeight + 10),

              TextFormField(
                autocorrect: false,
                controller: controller.kegiatanc,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: "Kegiatan PKL",
                  hintText: "Kegiatan PKL",
                  border: OutlineInputBorder()
                ),
              ),

                              const SizedBox(height: tFormHeight - 5),

                SizedBox(
                  width: double.infinity,
                  child:

                   ElevatedButton(
                    onPressed: () async{
                        // await controller.tambahmapel(position);
                        // print("${position.latitude}, ${position.longitude}");
                      Map<String, dynamic> dataResponse = await controller.determinePosition();
                      if (dataResponse["error"] != true) {
                        Position position= dataResponse["position"];

                        // Menghitung jarak antara dua lokasi
                        double distance = Geolocator.distanceBetween(
                          position.latitude,
                          position.longitude,
                          endLatitude,
                          endLongitude,
                        );
                          //bisa kalau 200000
                          // bisa kalau 100000
                          // bisa 10000 
                          // 100 = 1 meter
                        if (distance <= 100) {
                          
                        await controller.createabsen(position, mataPelajaran, uid);
                        // print("${position.latitude}, ${position.longitude}");

                        Get.snackbar("${dataResponse['message']}", "");
                        }else{
                          Get.snackbar("Gagal Melakukan Absensi", "Anda Berada Diluar Area");
                        }

                      }else{
                        Get.snackbar("Ada Kesalahan", dataResponse["message"]);
                      }
                    },
                    child: const Text("PRESENSI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
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
