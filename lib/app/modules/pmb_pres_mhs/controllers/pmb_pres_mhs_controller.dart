import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PmbPresMhsController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<String>> streampres_pmb() async* {
    String uid = auth.currentUser!.uid;

    // Ambil data pengguna berdasarkan UID
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await firestore.collection("users").doc(uid).get();

    // Ambil daftar nama lengkap dari data pengguna dengan role 'mahasiswa'
    List<String> namaLengkapList = [];
    if (userSnapshot.exists && userSnapshot.data()?['role'] == 'mahasiswa') {
      String namaLengkap = userSnapshot.data()?['nama_lengkap']?.toString() ?? '';
      namaLengkapList.add(namaLengkap);
    }

    // Emit daftar nama lengkap
    yield namaLengkapList;

    // Subscribes ke perubahan data koleksi users
    yield* firestore.collection("users").snapshots().map((snapshot) {
      // Mengupdate daftar nama lengkap jika ada perubahan
      return snapshot.docs
          .where((doc) => doc.data()?['role'] == 'mahasiswa')
          .map((doc) => doc.data()?['nama_lengkap']?.toString() ?? '')
          .toList();
    });
  }
}
