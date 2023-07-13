// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:presensi/app/routes/app_pages.dart';
// import 'package:tflite/tflite.dart';

// class PengenalWajahController extends GetxController {
//   final ImagePicker picker = ImagePicker();
//   Rx<XFile?> photo = Rx<XFile?>(null);
//   RxString nama = RxString('');
//   RxString confidencePercent = RxString('');
//   RxDouble confidenceValue = RxDouble(0.0);
//   bool isModelLoaded = false;

//   PengenalWajahController() {
//     loadMyModel();
//   }

//   Future<void> loadMyModel() async {
//     try {
//       await Tflite.loadModel(
//         labels: "assets/labels.txt",
//         model: "assets/model_unquant.tflite",
//         numThreads: 1,
//         isAsset: true,
//       );
//       isModelLoaded = true;
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }

//   void ambilgambar() async {
//     try {
//       final result = await picker.pickImage(source: ImageSource.camera);
//       if (result != null) {
//         photo.value = XFile(result.path);
//         update();
//         await applyModelOnImage(File(result.path));
//         Get.toNamed(Routes.PENGENAL_WAJAH, arguments: photo.value);
//       } else {
//         print(photo.value);
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//     }
//   }

//   Future<void> applyModelOnImage(File file) async {
//     try {
//       var recognitions = await Tflite.detectObjectOnImage(
//         path: file.path,
//         numResultsPerClass: 1,
//       );

//       if (recognitions != null && recognitions.isNotEmpty) {
//         dynamic detectedObject = recognitions[0];
//         String? name = detectedObject['detectedClass']?['label']?.toString();
//         double? confidence = detectedObject['confidence']?.toDouble();

//         confidencePercent.value = confidence != null ? '${(confidence * 100).toStringAsFixed(2)}%' : '';
//         confidenceValue.value = confidence ?? 0.0;

//         nama.value = name ?? 'Tidak terdeteksi';
//       } else {
//         nama.value = 'Tidak terdeteksi';
//         confidencePercent.value = '';
//         confidenceValue.value = 0.0;
//       }
//     } catch (e) {
//       print("Error applying model on image: $e");
//     }
//   }
// }


//image classification
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:tflite/tflite.dart';
import 'package:intl/intl.dart';

class PengenalWajahController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rx<XFile?> photo = Rx<XFile?>(null);
  RxString nama = RxString('');
  RxString confidencePercent = RxString('');
  RxDouble confidenceValue = RxDouble(0.0);
  bool isModelLoaded = false;

  PengenalWajahController() {
    loadMyModel();
  }

  Future<void> loadMyModel() async {
    var resultant = await Tflite.loadModel(
      labels: "assets/labels.txt",
      model: "assets/model_unquant.tflite",
      numThreads: 1, 
      isAsset: true,
    );
    print("Result after loading model: $resultant");

    if (resultant == "success") {
      isModelLoaded = true;
    }
  }
  void ambilgambar() async {
    final result = await picker.pickImage(source: ImageSource.camera);
    if (result != null) {
      photo.value = XFile(result.path);
      update();
      await applyModelOnImage(File(result.path)); // Menerapkan model pada gambar yang diambil
      Get.toNamed(Routes.PENGENAL_WAJAH, arguments: photo.value);
    } else {
      print(photo.value);
    }
  }

  Future<void> applyModelOnImage(File file) async {
    List<dynamic>? recognitions = await Tflite.runModelOnImage(
      path: file.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2,
      threshold: 0.5,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      String name = recognitions[0]['label']?.substring(2);
      double confidence = recognitions[0]['confidence'];

      confidenceValue.value = confidence;
      confidencePercent.value = '${(confidence * 100).toStringAsFixed(2)}%';
      nama.value = name;
    } else {
      nama.value = 'Tidak terdeteksi';
      confidenceValue.value = 0.0;
      confidencePercent.value = '';
    }
  }

  TextEditingController kegiatanc = TextEditingController();

  Future<void> createpresensi()async {
    DateTime now = DateTime.now();
    String tglabsen = DateFormat.yMd().format(now).replaceAll("/", "-");
  }
    

  Future<Map<String, dynamic>> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {
        "message": "Tidak dapat mengambil Posisi dari Device ini.",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
        "message": "Izin Menggunakan GPS ditolak.",
        "error": true,
        };
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition();
    Position position =  await Geolocator.getCurrentPosition();
      return {
      "position": position,
      "message": "Berhasil mendapatkan posisi",
      "error": false,
    };
  }
}