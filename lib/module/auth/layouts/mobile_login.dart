import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/module/auth/widget/login_form.dart';
import 'package:kemerahrfrontend/share/widgets/appbar.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.get('border', context),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: LoginForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
