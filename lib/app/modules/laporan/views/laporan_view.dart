import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/app/constants/colors.dart';
import 'package:presensi/app/constants/text_strings.dart';

import '../controllers/laporan_controller.dart';

class LaporanView extends GetView<LaporanController> {
   LaporanView({Key? key}) : super(key: key);
   final LaporanController laporanController = Get.put(LaporanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("Laporan Presensi",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.streampresensi(),
            builder: (context, snapPresensi) {
              if (snapPresensi.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapPresensi.data?.docs.length == 0 || snapPresensi.data == null) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text("Belum Ada Data Presensi"),
                  ),
                );
              }
              print(snapPresensi.data!.docs);
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapPresensi.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapPresensi.data!.docs[index].data();
                  return Container(
                    margin:const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                          const Text(
                            "Kegiatan : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          // Text("${DateFormat.jms().format(DateTime.now())}"),
                          Text(
                            "${DateFormat.yMMMEd().format(DateTime.parse(data['tgl_presensi']))}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                            
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              height: 50,
                                child: Text("${data['kegiatan']}"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                );
            }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => laporanController.PDF(),
        backgroundColor: tPrimaryColor,
        child: const Icon(Icons.download),
      ),

    );
  }
}
