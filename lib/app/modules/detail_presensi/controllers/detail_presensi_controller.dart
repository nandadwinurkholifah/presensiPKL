import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailPresensiController extends GetxController {
 Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getPresensi(String namaLengkap) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('nama_lengkap', isEqualTo: namaLengkap)
      .get();

    if (querySnapshot.docs.isNotEmpty) {
      String uid = querySnapshot.docs.first.id;
      Stream<QuerySnapshot<Map<String, dynamic>>> presensiStream = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('presensi')
          .orderBy('tgl_presensi')
          .snapshots();

      return Future.value(presensiStream);
    } else {
      // Handle ketika data pengguna tidak ditemukan
      throw Exception('Data pengguna tidak ditemukan');
    }
  }

}
