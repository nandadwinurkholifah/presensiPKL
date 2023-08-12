import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/modules/pengenal_wajah/controllers/pengenal_wajah_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../../home/controllers/home_controller.dart';

class PengenalWajahView extends GetView<PengenalWajahController> {
  const PengenalWajahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final XFile? photo = Get.arguments as XFile?;
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                    const Text(
                      'Belum ada gambar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: tFormHeight),
                    // Text("Nama: ${controller.nama.value}"),
                    Text(
                      "Nama Lengkap: ${controller.nama.value}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Akurasi: ${controller.confidencePercent.value}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: tFormHeight),

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

              const SizedBox(height: tFormHeight),

                SizedBox(
                  width: double.infinity,
                  child:
                  
                   Visibility(

                     child: ElevatedButton(
                      onPressed: () async{
                        Map<String, dynamic> dataResponse = await controller.determinePosition();
                        if (dataResponse["error"] != true) {
                          Position position= dataResponse["position"];
                          
                          
                            String namaLengkapUser = await controller.getNamaLengkapUser();
                            print("Nama Lengkap: $namaLengkapUser");
                            print("Controller Nama: ${controller.nama.value}");

                            bool isNamaLengkapMatched = controller.nama.value.trim() == namaLengkapUser.trim();
                            print("Is Nama Lengkap Matched: $isNamaLengkapMatched");
                            if (isNamaLengkapMatched) {
                              print(isNamaLengkapMatched);
                              await controller.createpresensi(position);
                              Get.snackbar("${dataResponse['message']}", "${position.latitude}, ${position.longitude}",backgroundColor: Colors.white);
                              Get.offAllNamed(Routes.HOME);
                            } else {
                              // print("gagal");
                              Get.offAllNamed(Routes.HOME);
                              Get.snackbar("Nama Tidak Cocok", "Nama tidak sesuai dengan nama lengkap pengguna");
                            }

                          

                        }else{
                          Get.snackbar("Ada Kesalahan", dataResponse["message"]);
                        }
                      },
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return CircularProgressIndicator();
                        } else{
                            return const Text("PRESENSI",
                            style: TextStyle(
                              fontWeight: FontWeight.bold),
                            );
                          }
                      }),
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
