import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle welcome = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.normal,
  );

  static TextStyle name = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle sectionTitle = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 19,
    fontWeight: FontWeight.w600,
  );
  static TextStyle sectionSubtitle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationColor: Colors.black,
  );
  
}
