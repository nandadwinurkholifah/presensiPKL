import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/theme/theme.dart';
import 'package:presensi/firebase_options.dart';
import 'app/services/firebase_service.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Inisialisasi FirebaseService dan panggil initializeFirestore
  final FirebaseService firebaseService = FirebaseService();
  await firebaseService.initializeFirestore();

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        // print(snapshot.data);
        return GetMaterialApp(
          themeMode: ThemeMode.system,
          theme: TappTheme.lightTheme,
          darkTheme: TappTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          title: tAppName,
          // initialRoute: AppPages.INITIAL,
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.WELCOME,
          // initialRoute: Routes.LOGIN,
          getPages: AppPages.routes,
        );
      }
    ),
  );
}
