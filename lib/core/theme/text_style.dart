import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle siemreap(
    BuildContext context, {
    double fontSize = 16,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.siemreap(
      fontSize: fontSize,
      color: color ?? Theme.of(context).colorScheme.onBackground,
      fontWeight: fontWeight,
    );
  }

  static TextStyle moul(
    BuildContext context, {
    double fontSize = 14,
    Color? color,
  }) {
    return GoogleFonts.moul(
      fontSize: fontSize,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle kantomruy(
    BuildContext context, {
    double fontSize = 14,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.kantumruyPro(
      fontSize: fontSize,
      color: color ?? Theme.of(context).colorScheme.onBackground,
      fontWeight: fontWeight,
    );
  }
}
