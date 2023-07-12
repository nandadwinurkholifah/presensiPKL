import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';

class Dropdown2View extends GetView {
  const Dropdown2View({Key? key, required this.onRoleTap, required this.rolevalue}) : super(key: key);

  final Function(String value) onRoleTap;
  final String rolevalue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: 
        Border.all(
          width: 1,
          color: tSecondaryColor,
        )
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: (){
                onRoleTap("mahasiswa");
              },
              child: Container(
                color: 
                rolevalue == "mahasiswa" ? tPrimaryColor: Colors.transparent,
              child:  Center(child: Text("Mahasiswa",
              style: rolevalue == "mahasiswa" ? const TextStyle(color: tWhiteColor) :const TextStyle(color: tSecondaryColor),
              ),
              ),
                      ),
            ),
          ),

          const VerticalDivider(
            width: 1, 
            color: tSecondaryColor,
          ),

          Flexible(
            flex: 1,
            child: InkWell(
              onTap: (){
                onRoleTap("pembimbing");
              },
              child: Container(
                color: 
                rolevalue == "pembimbing" ? tPrimaryColor: Colors.transparent,
              child: Center(child: Text("Pembimbing",
               style: rolevalue == "pembimbing" ? const TextStyle(color: tWhiteColor) :const TextStyle(color: tSecondaryColor),
              ),),
                      ),
            ))
        ],
      ),
    );
  }
}
