import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/data/models/featureitem.dart';
import 'package:kemerahrfrontend/module/page/admin.dart';
import 'package:kemerahrfrontend/module/page/hr.dart';
import 'package:kemerahrfrontend/module/page/staff.dart';

class MainController extends GetxController {
  int selectedIndex = 0;
  final selectuserid = Rxn<int>();
  int selectedFeatureIndex = 0;
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
        text: 'រដ្ឋបាល',
        textStyle: TextStyles.siemreap(context),
      ),
      GButton(
        icon: Icons.person,
        text: 'បុគ្គលិក',
        textStyle: TextStyles.siemreap(context),
      ),
    ];
  }

  List<List<FeatureItem>> moduleFeatures(BuildContext context) {
    return [
      // ✅ Admin Features
      [
        FeatureItem(
          icon: Icons.people,
          title: "សាខា", // Branch
          onTap: () {
            selectedFeatureIndex = 0;
            update(['feature_content']);
          },
        ),
        FeatureItem(
          icon: Icons.currency_exchange,
          title: "រូបិយប័ណ្ណ", // Currency
          onTap: () {
            selectedFeatureIndex = 1;
            update(['feature_content']);
          },
        ),
        FeatureItem(
          icon: Icons.currency_exchange,
          title: "រូបិយប័ណ្ណ", // Currency
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.account_tree,
          title: "នាយកដ្ឋាណ", // Department
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.school,
          title: "កម្រិតសិក្សា", // Education Level
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.badge,
          title: "ប្រភេទបុគ្គលិក", // Employee Type
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.swap_horiz,
          title: "អត្រាប្ដូរប្រាក់", // Exchange Rate
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.business,
          title: "ការិយាល័យ", // Office
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.work,
          title: "តួនាទី", // Position/Role
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.admin_panel_settings,
          title: "តួនាទីក្នុងប្រព័ន្ធ", // System Role
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.calendar_month,
          title: "វ៉េនធ្វេីការ", // Work Shift
          onTap: () {},
        ),
        FeatureItem(
          icon: Icons.access_time,
          title: "ម៉ោងធ្វេីការ", // Work Hours
          onTap: () {},
        ),
      ],

      // ✅ HR Features
      [
        FeatureItem(icon: Icons.work, title: "Employee", onTap: () {}),
        FeatureItem(icon: Icons.calendar_today, title: "Leave", onTap: () {}),
      ],

      // ✅ Staff Features
      [
        FeatureItem(icon: Icons.assignment, title: "My Task", onTap: () {}),
        FeatureItem(icon: Icons.access_time, title: "Attendance", onTap: () {}),
      ],
    ];
  }
}
