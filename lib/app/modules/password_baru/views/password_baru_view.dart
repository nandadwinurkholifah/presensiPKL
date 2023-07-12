import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/password_baru_controller.dart';

class PasswordBaruView extends GetView<PasswordBaruController> {
  const PasswordBaruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PasswordBaruView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PasswordBaruView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
