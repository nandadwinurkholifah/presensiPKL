import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/theme/theme.dart';
import 'package:presensi/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

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


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:presensi/app/constants/text_strings.dart';
// import 'package:presensi/app/theme/theme.dart';
// import 'package:presensi/firebase_options.dart';

// import 'app/routes/app_pages.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(
//     StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         }

//         User? user = snapshot.data;

//         return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//           future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const MaterialApp(
//                 home: Scaffold(
//                   body: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               );
//             }

//             String? role = snapshot.data?.data()?['role'];

//             String initialRoute = getInitialRoute(role);

//             return GetMaterialApp(
//               themeMode: ThemeMode.system,
//               theme: TappTheme.lightTheme,
//               darkTheme: TappTheme.darkTheme,
//               debugShowCheckedModeBanner: false,
//               title: tAppName,
//               initialRoute: initialRoute,
//               getPages: AppPages.routes,
//             );
//           },
//         );
//       },
//     ),
//   );
// }

// String getInitialRoute(String? role) {
//   if (role == 'admin') {
//     return Routes.HOME;
//   } else if (role == 'mahasiswa') {
//     return Routes.HOME_MHS;
//   } else if (role == 'pembimbing') {
//     return Routes.HOME_PMB;
//   } else {
//     return Routes.WELCOME;
//   }
// }
