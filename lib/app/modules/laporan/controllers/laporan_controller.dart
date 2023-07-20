

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:presensi/app/modules/pengenal_wajah/controllers/pengenal_wajah_controller.dart';
import 'package:intl/intl.dart';


class LaporanController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streampresensi() async* {
    String uid = auth.currentUser!.uid;
  
    yield* firestore.collection("users").doc(uid).collection("presensi").orderBy("tgl_presensi").snapshots();
  }
  
  Future<List<List<String>>> generateTableData() async {
    List<List<String>> data = [];

    String uid = auth.currentUser!.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("users")
        .doc(uid)
        .collection("presensi")
        .orderBy("tgl_presensi")
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      String tanggal = DateFormat('dd MMM yyyy HH:mm').format(DateTime.parse(doc.data()['tgl_presensi']));
      String kegiatan = doc.data()['kegiatan'] ?? '';

      data.add([tanggal, kegiatan]);
    }

    return data;
  }




  void PDF () async{
    //uid yg sedang login
    String uid = auth.currentUser!.uid;
    
    // Mendapatkan data pengguna
    DocumentSnapshot<Map<String, dynamic>> userData = await firestore.collection("users").doc(uid).get();

    //class pdf 
    final pdf = pw.Document();
    
    // Menambahkan font yang mendukung Unicode 
    final fontData = await rootBundle.load('assets/fonts/Poppins/Poppins-Regular.ttf');
    final customFont = pw.Font.ttf(fontData);

    // Memuat gambar dari direktori assets
    final Uint8List imageData = (await rootBundle.load('assets/images/cop_pkl.PNG')).buffer.asUint8List();

    // Membuat halaman PDF
    List<List<String>> tableData = await generateTableData();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                   pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Image(pw.MemoryImage(imageData), width: 200, height: 200), // Gambar di tengah
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "NIM: ${userData['nim']}",
                    style: pw.TextStyle(
                      font: customFont,
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "Nama Mahasiswa: ${userData['nama_lengkap']}",
                    style: pw.TextStyle(
                      font: customFont,
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            pw.Table.fromTextArray(
              headers: ['NO', 'Tanggal, Pukul', 'Laporan kerja yang dihasilkan', 'Tanda Tangan PL', 'Catatan PL'],
              data: List<List<String>>.generate(
                tableData.length,
                (index) {
                  return [
                    (index + 1).toString(),
                    tableData[index][0],
                    tableData[index][1],
                    '', // Tanda Tangan PL
                    '', // Catatan PL
                  ];
                },
              ),
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellStyle: const pw.TextStyle(),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
            ),
          ];
        },
      ),
    );


    //simpan pdf
    Uint8List bytes = await pdf.save();

    //buat file kosong di direktori hp
    final dir = await getExternalStorageDirectory();

    //membuat nama file sesuai nama pengguna yg sedang login

    //dari controller pengenalan wajah
    PengenalWajahController namaController = Get.put<PengenalWajahController>(PengenalWajahController());
    

    
    //mendapat nama lengkapnya
    String namaLengkap = await namaController.getNamaLengkapUser();

    // Menghilangkan spasi pada nama lengkap
    String namaFile = namaLengkap.replaceAll(' ', '_');

    // Menambahkan ekstensi .pdf ke nama file
    // String namaFilePDF = '$namaFile.pdf';
    final file = File('${dir!.path}/$namaFile.pdf');

    //timpa file kosong  dengan file pdf
    await file.writeAsBytes(bytes);

    //open pdf
    await openPDF(file.path);
    // print('PDF dibuka');
  }

  Future<void> openPDF(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      print('PDF opened: $result');
    } catch (e) {
      print('Failed to open PDF: $e');
    }
  }
  
}
