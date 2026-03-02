import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/core/theme/theme_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;

  const CustomAppBar({Key? key, required this.title, this.height = 70})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController controller = Get.find();

    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.get('primary', context),
      iconTheme: IconThemeData(color: AppColors.get('text', context)),
      title: Text(
        title,
        style: TextStyles.moul(
          context,
          color: AppColors.get('text', context),
          fontSize: 20,
        ),
      ),

      // 🔥 Toggle Button Here
      actions: [
        Obx(
          () => IconButton(
            icon: Icon(
              controller.isDark.value ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.get('text', context),
            ),
            onPressed: controller.toggleTheme,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
