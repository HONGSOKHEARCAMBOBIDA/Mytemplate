import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomSnackbar {
  static void success({required String title, required String message}) {
    final context = Get.context!;
    if (context == null) return;
    final breakpoin = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoin.isMobile;
    Get.snackbar(
      '',
      '',
      maxWidth: isMobile ? double.infinity : 400.0,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.get('success', context),
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
      isDismissible: true,
      // isDismissible tell user can switch to close or not
      dismissDirection: DismissDirection.horizontal,
      // what direction user can switch
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeInCubic,
      snackStyle: SnackStyle.FLOATING,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          Icons.check_circle_rounded,
          color: AppColors.get('text', context),
          size: 22,
        ),
      ),
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.get('text', context),
          height: 1.3,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: AppColors.get('text', context),
          height: 1.4,
        ),
      ),
    );
  }

  static void error({required String title, required String message}) {
    final context = Get.context!;
    final breakpoin = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoin.isMobile;
    Get.snackbar(
      '',
      '',
      maxWidth: isMobile ? double.infinity : 400.0,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.get('error', context),
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeOut,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          Icons.error_outline_rounded,
          color: AppColors.get('text', context),
          size: 22,
        ),
      ),
      titleText: Text(
        title,
        style: GoogleFonts.siemreap(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.get('text', context),
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.siemreap(
          fontSize: 13,
          color: AppColors.get('text', context),
        ),
      ),
      mainButton: TextButton(
        child: Icon(
          Icons.close,
          color: AppColors.get('text', context),
          size: 18,
        ),
        onPressed: () => Get.back(),
      ),
    );
  }
}

enum SnackbarType { success, error, warning, info }

extension SnackbarExtension on GetInterface {
  void showSuccess(String title, String message) {
    CustomSnackbar.success(title: title, message: message);
  }

  void showError(String title, String message) {
    CustomSnackbar.error(title: title, message: message);
  }
}
