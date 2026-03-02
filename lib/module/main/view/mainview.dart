import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/module/main/controller/maincontroller.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return Scaffold(
      backgroundColor: AppColors.get('background', context),
      body: responsive.isDesktop ? _webLayout(context) : _mobileLayout(),
      bottomNavigationBar: responsive.isDesktop ? null : _bottomNav(context),
    );
  }

  Widget _mobileLayout() {
    // REMOVED Scaffold from here - only use the one in build()
    return GetBuilder<MainController>(
      id: 'index_stack',
      builder: (controller) {
        return IndexedStack(
          index: controller.selectedIndex,
          children: controller.lstscreen,
        );
      },
    );
  }

  Widget _bottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.get('background', context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: GetBuilder<MainController>(
            id: 'bottom_navigation_bar',
            builder: (controller) {
              return GNav(
                color: AppColors.get('text', context),
                backgroundColor: Colors.transparent,
                activeColor: Colors.white,
                tabBackgroundColor: AppColors.get('primary', context),
                tabBorderRadius: 12,
                gap: 8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                selectedIndex: controller.selectedIndex,
                onTabChange: controller.onItemTapped,
                tabs: controller.getTabs(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _webLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          color: AppColors.get('background', context),
          child: GetBuilder<MainController>(
            id: 'bottom_navigation_bar',
            builder: (controller) {
              return NavigationRail(
                indicatorColor: AppColors.get('text', context),
                backgroundColor: AppColors.get('background', context),
                selectedIndex: controller.selectedIndex,
                onDestinationSelected: controller.onItemTapped,
                labelType: NavigationRailLabelType.all,
                destinations: controller.getTabs(context).map((tab) {
                  return NavigationRailDestination(
                    icon: Icon(
                      tab.icon,
                      color: AppColors.get('primary', context),
                    ),
                    label: Text(tab.text ?? ""),
                  );
                }).toList(),
              );
            },
          ),
        ),
        Expanded(
          child: GetBuilder<MainController>(
            id: 'index_stack',
            builder: (controller) {
              return IndexedStack(
                index: controller.selectedIndex,
                children: controller.lstscreen,
              );
            },
          ),
        ),
      ],
    );
  }
}
