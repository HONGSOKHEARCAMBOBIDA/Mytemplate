// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/core/theme/theme_controller.dart';
import 'package:kemerahrfrontend/module/page/managepage.dart';
import 'package:responsive_framework/responsive_framework.dart'; // Add this import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.isDark.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: Managepage.INITIAL,
        getPages: Managepage.routes,
        // Fix: Move builder outside of GetMaterialApp's parameters
        builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
        },
        defaultTransition: Transition.fadeIn,
      ),
    );
  }
}
