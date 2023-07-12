import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';
import 'package:presensi/app/modules/add_mahasiswa/views/dropdown2_view.dart';
import 'package:presensi/app/modules/add_mahasiswa/views/dropdown_view.dart';

import '../controllers/add_mahasiswa_controller.dart';

class AddMahasiswaView extends GetView<AddMahasiswaController> {
  const AddMahasiswaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("Tambah Mahasiswa",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Container(
            padding:  const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                //  AddGuruFormView(),

                //nim
                Text(tnim, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                TextFormField(
                autocorrect: false,
                  controller: controller.nimc,
                  decoration: const InputDecoration(
                    // label: Text(tnip), 
                    prefixIcon: Icon(Icons.assignment_ind_outlined)
                    ),
                ),

                const SizedBox(height: tFormHeight),
                
                //nama
                Text(tNamalngkp, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                TextFormField(
                autocorrect: false,
                  controller: controller.namac,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder()),
                ),

                const SizedBox(height: tFormHeight),

                //email
                Text(tEmail, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                TextFormField(
                  autocorrect: false,
                  controller: controller.emailc,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined)),
                ),

                const SizedBox(height: tFormHeight),

                // //jk
                Text(tjk, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                Obx(() => DropdownView(
                  onJKTap: onJKTap, 
                  jenkelvalue: controller.jenkel.value)),

                const SizedBox(height: tFormHeight),

                //alamat
                Text(talamat, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                TextFormField(
                autocorrect: false,
                  controller: controller.alamatc,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    border: OutlineInputBorder()),
                ),

                const SizedBox(height: tFormHeight),

                //role
                // Text("Role", style: Theme.of(context).textTheme.headline4),
                // const SizedBox(height: tFormHeight - 10),


                // Obx(() => Dropdown2View(
                //   onRoleTap: onRoleTap, 
                //   rolevalue: controller.role.value)),

                // const SizedBox(height: tFormHeight),

                
                SizedBox(
                  width: double.infinity,
                  child:

                  Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.Addmhs();
                      }
                    },
                    child: Text(controller.isLoading.isFalse? "Tambah Mahasiswa".toUpperCase() : "LOADING...",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
  void onJKTap( String jenkel){
    
      controller.jenkel.value = jenkel;
      // print(jenkel);
    
  }
  void onRoleTap( String role){
    
      controller.role.value = role;
      
    
  }
}
