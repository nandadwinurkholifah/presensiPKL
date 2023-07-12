import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/sizes.dart';
import 'package:presensi/app/constants/text_strings.dart';

import '../controllers/add_pembimbing_controller.dart';

class AddPembimbingView extends GetView<AddPembimbingController> {
  const AddPembimbingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("Tambah Pembimbing",
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

                //nid
                Text(tnidn, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: tFormHeight - 10),

                TextFormField(
                autocorrect: false,
                  controller: controller.nidnc,
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
                  controller: controller.namapc,
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
                  controller: controller.emailpc,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined)),
                ),

                const SizedBox(height: tFormHeight),

                SizedBox(
                  width: double.infinity,
                  child:

                  Obx(() => ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.Addpmb();
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
}
