import 'package:flutter/material.dart';

class FeatureItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  FeatureItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}