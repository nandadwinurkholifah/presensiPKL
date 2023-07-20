import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi/app/constants/colors.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
   final String namaLengkap;
  const DetailPresensiView({Key? key, required this.namaLengkap}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: const Text("Detail Presensi",
        style: TextStyle(
          color: tWhiteColor, 
          fontWeight: FontWeight.bold,
         )
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<Stream<QuerySnapshot<Map<String, dynamic>>>>(
        future: controller.getPresensi(namaLengkap),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error in retrieving data'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final presensiStream = snapshot.data;
          if (presensiStream == null) {
            return const Center(
              child: Text('Tidak ada data presensi'),
            );
          }

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: presensiStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error in retrieving data'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final docs = snapshot.data?.docs;
              if (docs == null || docs.isEmpty) {
                return const Center(
                  child: Text('Tidak ada data presensi'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data();
                  // Tampilkan data presensi sesuai kebutuhan

                  // return ListTile(
                  //   title: Text(data['kegiatan']),
                  //   subtitle: Text(data['tgl_presensi'].toString()),
                  // );

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
            },
          );
        },
      ),
    );
  }
}
