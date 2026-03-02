import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/module/page/admin.dart';
import 'package:kemerahrfrontend/module/page/hr.dart';
import 'package:kemerahrfrontend/module/page/staff.dart';

class MainController extends GetxController {
  int selectedIndex = 0;
  final selectuserid = Rxn<int>();

  final List<Widget> lstscreen = [Admin(), Hr(), Staff()];

  void onItemTapped(int index) {
    selectedIndex = index;
    update(['index_stack', 'bottom_navigation_bar']);
  }

  List<GButton> getTabs(BuildContext context) {
    return [
      GButton(
        icon: Icons.admin_panel_settings,
        text: 'អ្នកកាន់ប្រព័ន្ធ',
        textStyle: TextStyles.siemreap(context),
      ),
      GButton(
        icon: Icons.account_balance,
        text: 'កម្ចី',
        textStyle: TextStyles.siemreap(context),
      ),
      GButton(
        icon: Icons.person,
        text: 'គណនេយ្យ',
        textStyle: TextStyles.siemreap(context),
      ),
    ];
  }
}
