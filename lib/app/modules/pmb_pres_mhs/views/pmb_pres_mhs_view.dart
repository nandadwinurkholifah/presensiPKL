import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pmb_pres_mhs_controller.dart';

class PmbPresMhsView extends GetView<PmbPresMhsController> {
  const PmbPresMhsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PmbPresMhsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PmbPresMhsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
