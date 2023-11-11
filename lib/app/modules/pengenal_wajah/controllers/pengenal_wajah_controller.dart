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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
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
  String get namaLengkapUser => FirebaseAuth.instance.currentUser?.displayName ?? '';

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

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

  // Future<void> createpresensi(Position position) async {
  //   isLoading.value = true;

  //   String uid = auth.currentUser!.uid;

  //   CollectionReference<Map<String, dynamic>> colPres =
  //       firestore.collection("users").doc(uid).collection("presensi");

  //   QuerySnapshot<Map<String, dynamic>> snapPres = await colPres.get();

  //   DateTime now = DateTime.now();
  //   String tglabsen = DateFormat.yMd().format(now).replaceAll("/", "-");

  //   if (snapPres.docs.length == 0) {
  //     DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //         await firestore.collection("users").doc(uid).get();

  //     double userLatitude = userSnapshot.data()?["alamat_pkl"]?["lat"];
  //     double userLongitude = userSnapshot.data()?["alamat_pkl"]?["long"];

  //     if (userLatitude != null && userLongitude != null) {
  //       double distance = Geolocator.distanceBetween(
  //         position.latitude,
  //         position.longitude,
  //         userLatitude,
  //         userLongitude,
  //       );
  //         // xollovoling distance 1000, lokasi mushollah
  //         // 100 = 1 meter
  //       if (distance <= 1000) { 
  //         await colPres.doc(tglabsen).set({
  //           // "date": now.toIso8601String(),
  //           "tgl_presensi": now.toIso8601String(),
  //           "lokasi": {
  //             "lat": position.latitude,
  //             "long": position.longitude,
  //           },
  //           "foto": await _uploadImage(File(photo.value!.path)), // Mengubah XFile menjadi File
  //           "kegiatan": kegiatanc.text,
  //         });
  //         Get.snackbar("Presensi Berhasil", "");
  //         Get.offAllNamed(Routes.HOME);
  //       } else {
  //         Get.snackbar("Gagal Melakukan Absensi", "Anda Berada Diluar Area");
  //       }
  //     } else {
  //       Get.snackbar("Gagal Melakukan Absensi", "Lokasi pengguna tidak tersedia");
  //     }
  //   } else {
  //     Get.back();
  //     Get.snackbar("Sudah Melakukan Presensi", "Anda Tidak Perlu Melakukan Presensi");
  //   }
  //   isLoading.value = false;
  // }

 Future<String> getNamaLengkapUser() async {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
  return userSnapshot.data()?["nama_lengkap"] ?? '';
}


  Future<void> createpresensi(Position position) async {
  isLoading.value = true;

  String uid = auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> colPres =
      firestore.collection("users").doc(uid).collection("presensi");

  QuerySnapshot<Map<String, dynamic>> snapPres = await colPres.get();

  DateTime now = DateTime.now();
  String tglabsen = DateFormat.yMd().format(now).replaceAll("/", "-");

  if (snapPres.docs.length == 0) {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await firestore.collection("users").doc(uid).get();

    double userLatitude = userSnapshot.data()?["alamat_pkl"]?["lat"];
    double userLongitude = userSnapshot.data()?["alamat_pkl"]?["long"];

    if (userLatitude != null && userLongitude != null) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        userLatitude,
        userLongitude,
      );
      // xollovoling distance 1000, lokasi mushollah
      // 100 = 1 meter
      if (distance <= 20000) {
        await colPres.doc(tglabsen).set({
          "tgl_presensi": now.toIso8601String(),
          "lokasi": {
            "lat": position.latitude,
            "long": position.longitude,
          },
          "kegiatan": kegiatanc.text,
          "foto": await _uploadImage(File(photo.value!.path)),
        });
        Get.snackbar("Berhasil mendapatkan posisi", "${position.latitude}, ${position.longitude}",backgroundColor: Colors.white);
        Get.snackbar("Presensi Berhasil", "");
        Get.offAllNamed(Routes.HOME);
      
      } else {
        Get.snackbar("Gagal Melakukan Absensi", "Anda Berada Diluar Area");
      }
    } else {
      Get.snackbar("Gagal Melakukan Absensi", "Lokasi pengguna tidak tersedia");
    }
  } else {
    
    // hari selanjutnya 
    DocumentSnapshot<Map<String, dynamic>> hari_ini = await colPres.doc(tglabsen).get();
    // print(hari_ini.exists);
    if (hari_ini.exists == true) {
      Get.back();
      Get.snackbar("Sudah Melakukan Presensi", "Anda Tidak Perlu Melakukan Presensi");
    } else{
        await colPres.doc(tglabsen).set({
          "tgl_presensi": now.toIso8601String(),
          "lokasi": {
            "lat": position.latitude,
            "long": position.longitude,
          },
          "kegiatan": kegiatanc.text,
          "foto": await _uploadImage(File(photo.value!.path)),
        });
        Get.snackbar("Presensi Berhasil", "");
        Get.offAllNamed(Routes.HOME);
    }
  }
  isLoading.value = false;
}


  Future<File?> compressImage(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        tempFilePath,
        quality: 20, // Ubah nilai quality sesuai kebutuhan Anda
      );

      return result;
    } catch (e) {
      print('Error compressing image: $e');
      return null;
    }
  }

  Future<String> _uploadImage(File file) async {
  try {
    String uid = auth.currentUser!.uid;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child(uid)
        .child('presensi')
        .child('$fileName.jpg');

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
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