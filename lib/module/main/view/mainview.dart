import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/core/theme/theme_controller.dart';
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
  return Column(
    children: [
      _topNavigation(context),   // ✅ like Excel ribbon tabs
      _featureToolbar(context),
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
Widget _topNavigation(BuildContext context) {
  final ThemeController themeController = Get.find();
  return Container(
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: AppColors.get('background', context),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
        ),
      ],
    ),
    child: GetBuilder<MainController>(
      id: 'bottom_navigation_bar',
      builder: (controller) {
        return Row(
          children: [
            Row(
              children: List.generate(
                controller.getTabs(context).length,
                (index) {
                  final tab = controller.getTabs(context)[index];
                  final isSelected = controller.selectedIndex == index;
            
                  return GestureDetector(
                    onTap: () => controller.onItemTapped(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.get('primary', context)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            tab.icon,
                            size: 15,
                            color: isSelected
                                ? Colors.white
                                : AppColors.get('text', context),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tab.text ?? "",
                            style: TextStyles.siemreap(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.get('text', context),context
                            ),
                          ),
                       
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
                       Obx(
          () => IconButton(
            icon: Icon(
              themeController.isDark.value ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.get('text', context),
            ),
            onPressed: themeController  .toggleTheme,
          ),
        ),
          ],
        );
      },
    ),
  );
}
Widget _featureToolbar(BuildContext context) {
  return GetBuilder<MainController>(
    id: 'bottom_navigation_bar',
    builder: (controller) {
      final features =
          controller.moduleFeatures(context)[controller.selectedIndex];

      return Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.get('background', context),
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: features.asMap().entries.map((entry) {
            final index = entry.key;
            final feature = entry.value;

            final isSelected =controller.selectedFeatureIndex == index;

            return GestureDetector(
              onTap: () {
                controller.selectedFeatureIndex = index;
                feature.onTap(); // optional
                controller.update(
                    ['feature_content', 'bottom_navigation_bar']);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.get('success', context)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature.icon,
                      size: 22,
                      color: isSelected ? Colors.white : null,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      feature.title,
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 12,
                        color: isSelected ? Colors.white : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    },
  );
}
}
