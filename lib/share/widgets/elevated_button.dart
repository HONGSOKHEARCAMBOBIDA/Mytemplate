import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double borderRadius;
  final double fontSize;
  final double width;
  final double height;
  final IconData? icon;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.borderRadius = 14,
    this.fontSize = 16.0,
    this.width = double.infinity,
    this.height = 50.0,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.get('primary', context),
          foregroundColor: AppColors.get('text', context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.siemreap(
            context,
            fontWeight: FontWeight.w700,
            color: AppColors.get('text', context),
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
