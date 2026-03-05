import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/module/auth/widget/login_form.dart';

class DesktopLogin extends StatelessWidget {
  const DesktopLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueGrey.shade900,
              child: Center(
                child: Text(
                  "ប្រព័ន្ធគ្រប់គ្រងធនធានមនុស្ស",
                  style: TextStyles.moul(
                    context,
                    fontSize: 40,
                    color: AppColors.get('warning', context),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: SizedBox(
                width: 420,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: LoginForm(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
