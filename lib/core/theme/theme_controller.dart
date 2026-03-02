import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final isDark = false.obs;

  void toggleTheme() {
    isDark.toggle();
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6200EE),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    colorScheme: const ColorScheme.light(primary: Color(0xFF6200EE)),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFBB86FC),
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(primary: Color(0xFFBB86FC)),
  );
}
