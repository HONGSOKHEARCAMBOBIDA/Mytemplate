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
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'asset/image/background.png',
                width: 1100,
                height: 600,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: SizedBox(
                width: 520,
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
