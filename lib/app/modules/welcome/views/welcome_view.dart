import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/routes/app_pages.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    // var height = MediaQuery.of(context).size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
       backgroundColor: isDarkMode? tSecondaryColor :tPrimaryColor,
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Text(twelcometitel, 
                  style: TextStyle(
                    color: tWhiteColor,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,),
              ],
            ),
               const Center(
                child: 
                // Image.asset('images/logo_absensi_pegawai_2.png'),
                 Image(image:  AssetImage('assets/images/logo_absensi_pegawai_2.png'), height: 200, width: 200,),
               ),
            // Image.asset('images/coba.jpg'),
           
            const Text(twelcomesubtitle, 
                  style: TextStyle(
                    color: tWhiteColor,
                    fontSize: 23.0,
                  ),
                  textAlign: TextAlign.center,),
            Row(
              children: [
                Expanded(child: 
                  OutlinedButton(
                    onPressed: ()=> Get.toNamed(Routes.LOGIN),
                    style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    foregroundColor: tWhiteColor,
                    side: const BorderSide(color: tWhiteColor),
                    padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
                    ), 
                    child: const Text(tstart),
                  ),
                ),
                  const SizedBox(
                  width: 10.0,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
