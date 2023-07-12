
//light 7 dark themes


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presensi/app/constants/colors.dart';


class TTextTheme{
  TTextTheme._();

  // light theme
  static TextTheme lighTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(fontSize: 28.0, fontWeight: FontWeight.bold, color: tDarkColor),
    headline2: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.w700, color: tDarkColor),
    headline3: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: tDarkColor),
    headline4: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600, color: tDarkColor),
    bodyText1: GoogleFonts.poppins(fontSize: 20.0, fontWeight: FontWeight.w700, color: tDarkColor),
    
  );

  //dark theme
  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(fontSize: 28.0, fontWeight: FontWeight.bold, color: tWhiteColor),
    headline2: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.w700, color: tWhiteColor),
    headline3: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    headline4: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600, color: tWhiteColor),
    bodyText1: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.normal, color: tWhiteColor),
  );

}