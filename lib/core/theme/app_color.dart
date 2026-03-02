// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const light = {
    'primary': Color(0xFF2F80ED),
    'secondary': Color(0xFF27AE60),

    'background': Color(0xFFF7F9FC),
    'surface': Color(0xFFFFFFFF),
    'text': Color(0xFF1A1A1A),
    'border': Color.fromARGB(255, 35, 90, 154),

    // 🔹 Snackbar / Status colors
    'success': Color(0xFF27AE60), // Green
    'error': Color(0xFFEB5757), // Red
    'warning': Color(0xFFF2C94C), // Yellow
    'info': Color(0xFF2F80ED), // Blue
  };

  static const dark = {
    'primary': Color(0xFF4A90E2),
    'secondary': Color(0xFF2ECC71),

    'background': Color(0xFF0F172A),
    'surface': Color(0xFF1E293B),
    'text': Color(0xFFF8FAFC),
    'border': Color.fromARGB(255, 212, 226, 246),

    // 🔹 Snackbar / Status colors (adjusted for dark)
    'success': Color(0xFF22C55E),
    'error': Color(0xFFEF4444),
    'warning': Color(0xFFFACC15),
    'info': Color(0xFF60A5FA),
  };

  static Color get(String colorName, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMap = isDark ? dark : light;
    return themeMap[colorName] ?? Colors.transparent;
  }
}
