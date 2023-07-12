import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/constants/colors.dart';

class DropdownView extends GetView {
  const DropdownView({Key? key, required this.onJKTap, required this.jenkelvalue}) : super(key: key);

  final Function(String value) onJKTap;
  final String jenkelvalue;
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
                onJKTap("Laki - laki");
              },
              child: Container(
                color: 
                jenkelvalue == "Laki - laki" ? tPrimaryColor: Colors.transparent,
              child:  Center(child: Text("Laki - laki",
              style: jenkelvalue == "Laki - laki" ? const TextStyle(color: tWhiteColor) :const TextStyle(color: tSecondaryColor),
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
                onJKTap("Perempuan");
              },
              child: Container(
                color: 
                jenkelvalue == "Perempuan" ? tPrimaryColor: Colors.transparent,
              child: Center(child: Text("Perempuan",
               style: jenkelvalue == "Perempuan" ? const TextStyle(color: tWhiteColor) :const TextStyle(color: tSecondaryColor),
              ),),
                      ),
            ))
        ],
      ),
    );
  }
}
