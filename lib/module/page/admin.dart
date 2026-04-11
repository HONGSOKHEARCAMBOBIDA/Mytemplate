import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/module/branch/view/branchview.dart';
import 'package:kemerahrfrontend/module/main/controller/maincontroller.dart';
import 'package:kemerahrfrontend/module/page/currencypage.dart';
class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      id: 'feature_content',
      builder: (controller) {
        final pages = [
          Branchview(),
          Currencypage(),
        ];
        return pages[controller.selectedFeatureIndex];
      },
    );
  }
}