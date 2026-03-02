import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/module/auth/controller/authcontroller.dart';
import 'package:kemerahrfrontend/share/widgets/appbar.dart';
import 'package:kemerahrfrontend/share/widgets/customtextfield.dart';
import 'package:kemerahrfrontend/share/widgets/elevated_button.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController controller = Get.find<AuthController>();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoint.isMobile;

    return Scaffold(
      appBar: CustomAppBar(title: ""),
      backgroundColor: AppColors.get('background', context),
      body: Padding(
        padding: EdgeInsets.only(
          left: isMobile ? 8 : 750,
          right: isMobile ? 8 : 750,
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.get('background', context),
              border: Border.all(
                width: 0.5,
                color: AppColors.get('border', context),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/15879/15879738.png",
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: usernameController,
              hintText: "លេខទូរសព្ទ",
              prefixIcon: Icons.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "សូមបញ្ចូលលេខទូរសព្ទ";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              hintText: "លេខកូដ",
              prefixIcon: Icons.lock,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "សូមបញ្ចូលលេខកូដ";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Obx(() {
              return CustomElevatedButton(
                text: controller.isLoading.value ? "កំពុងភ្ជាប់..." : "ចូល",
                onPressed: controller.isLoading.value
                    ? () {}
                    : () {
                        if (_formKey.currentState!.validate()) {
                          controller.login(
                            username: usernameController.text,
                            password: passwordController.text,
                          );
                        }
                      },
              );
            }),
          ],
        ),
      ),
    );
  }
}
