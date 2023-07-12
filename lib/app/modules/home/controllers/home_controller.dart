import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presensi/app/modules/pengenal_wajah/controllers/pengenal_wajah_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final PengenalWajahController wajahController = Get.put(PengenalWajahController());
  RxInt pageIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxString role = ''.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadRole();
  }

  void loadRole() async {
    String uid = auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore.collection("users").doc(uid).get();
    role.value = snapshot.data()?['role'] ?? "";
  }

  void changePage(int index) {
    pageIndex.value = index;
    String roles = role.value;

    if (roles == 'admin' || roles == 'mahasiswa') {
      switch (index) {
        case 1:
           wajahController.ambilgambar();
          break;
        case 2:
          Get.toNamed(Routes.PROFILE);
          // print("tengah");
          break;
        default:
          Get.toNamed(Routes.HOME);
          // print("pertama");
          break;
      }
    } else {
      switch (index) {
        case 1:
          Get.toNamed(Routes.PROFILE);
          break;
        default:
          Get.toNamed(Routes.HOME);
          break;
      }
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamrole() {
    String uid = auth.currentUser!.uid;
    return firestore.collection("users").doc(uid).snapshots();
  }
}
