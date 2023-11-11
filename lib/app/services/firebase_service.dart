import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


class FirebaseService extends GetxService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> initializeFirestore() async {
    final QuerySnapshot adminSnapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .limit(1)
        .get();

    if (adminSnapshot.docs.isEmpty) {
      await createAdminUser();
    }

    // Tambahkan data lain yang diperlukan
  }

  Future<void> createAdminUser() async {
    try {
      // Cek apakah admin sudah ada
      final QuerySnapshot adminSnapshot = await firestore
          .collection('users')
          .where('role', isEqualTo: 'admin')
          .limit(1)
          .get();

      if (adminSnapshot.docs.isEmpty) {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: 'nd.nurkholifah@unim.ac.id',
          password: 'admin123',
        );

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          await firestore.collection('users').doc(uid).set({
            'nama_lengkap': 'Admin',
            'email': userCredential.user!.email, // Mengambil email dari userCredential
            'uid': uid,
            'role': 'admin',
            'created_at': DateTime.now().toIso8601String(),
          });
          await userCredential.user!.sendEmailVerification();
        }
        await auth.signOut();
      }
    } catch (e) {
      // Tangani kesalahan jika ada
      print('Error creating admin user: $e');
    }
  }
}