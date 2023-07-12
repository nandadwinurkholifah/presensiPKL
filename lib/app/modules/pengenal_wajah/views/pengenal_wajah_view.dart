import 'dart:io';

import 'package:flutter/material.dart';
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("ABSENSI"),
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
