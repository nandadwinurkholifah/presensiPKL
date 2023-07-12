import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode? tSecondaryColor :tWhiteColor,
        body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          // padding: const EdgeInsets.symmetric(vertical: tFormHeight + 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // section 1
              
               const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
               const Center(
                child: 
                // Image(image: const AssetImage(tloginimage), height: size.height * 0.2, ),
                Image(image: AssetImage('assets/images/logo.png')),
                // Image.asset('images/logo.png'),
                // width: size.width
                
               ),
              
              const SizedBox(height: tFormHeight + 10),

              Center(
                child: Text(
                  tlogintitle, 
                  style: Theme.of(context).textTheme.headline1, 
                  textAlign: TextAlign.center,
                ),
              ),

              
              const SizedBox(height: tFormHeight + 10),
              //section 2
              // const LoginFormView(),
              TextFormField(
                autocorrect: false,
                controller: controller.emailc,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: tEmail,
                  hintText: tEmail,
                  border: OutlineInputBorder()
                ),
              ),
              
              const SizedBox(height: tFormHeight),

              TextFormField(
                autocorrect: false,
                controller: controller.passc,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: OutlineInputBorder(),
                  
                ),
              ),
              const SizedBox(height: tFormHeight),
              
              SizedBox(
                width: double.infinity,
                child: 
                Obx(() => 
                  ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                        await controller.login();
                    }
                  },
                  child: Text( controller.isLoading.isFalse ? tLogin.toUpperCase(): "LOADING..."),
                )
                ),
              ),

              const SizedBox(height: tFormHeight - 10),

              TextButton(
                onPressed: () {},
                // => Get.toNamed(Routes.LUPA_PASSWORD), 
                child: const Text("Lupa Password ?"),)

            ],
          ),
        ),
      ),
    )
      );
  }
}
