import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/module/auth/controller/authcontroller.dart';
import 'package:kemerahrfrontend/share/widgets/customtextfield.dart';
import 'package:kemerahrfrontend/share/widgets/elevated_button.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      controller.login(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "ចូលប្រព័ន្ធ",
            style: TextStyles.siemreap(
              context,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          CustomTextField(controller: emailController, hintText: "Username"),

          const SizedBox(height: 20),

          CustomTextField(controller: passwordController, hintText: "Password"),

          const SizedBox(height: 25),

          Obx(() {
            return CustomElevatedButton(
              text: controller.isLoading.value ? "កំពុងភ្ជាប់..." : "ចូល",
              onPressed: controller.isLoading.value ? null : _login,
            );
          }),
        ],
      ),
    );
  }
}
