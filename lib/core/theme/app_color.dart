// lib/core/constants/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const light = {
    'primary': Color(0xFF2563EB),
    'secondary': Color(0xFF27AE60),

    'background': Color(0xFFF8FAFC),
    'surface': Color(0xFFFFFFFF),
    'text': Color(0xFF1E293B),
    'border': Color.fromARGB(255, 153, 192, 244),

    // 🔹 Snackbar / Status colors
    'success': Color(0xFF22C55E), // Green
    'error': Color(0xFFEF4444), // Red
    'warning': Color(0xFFFF59E0B), // Yellow
    'info': Color(0xFF0EA5E9), // Blue
  };

  static const dark = {
    'primary': Color(0xFF3B82F6),
    'secondary': Color(0xFF2ECC71),

    'background': Color(0xFF0F172A),
    'surface': Color(0xFF1E293B),
    'text': Color(0xFFF1F5F9),
    'border': Color(0xFF334155),

    // 🔹 Snackbar / Status colors (adjusted for dark)
    'success': Color(0xFF4ADE80),
    'error': Color(0xFFF87171),
    'warning': Color(0xFFFBBF24),
    'info': Color(0xFF38BDF8),
  };

  static Color get(String colorName, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMap = isDark ? dark : light;
    return themeMap[colorName] ?? Colors.transparent;
  }
}
