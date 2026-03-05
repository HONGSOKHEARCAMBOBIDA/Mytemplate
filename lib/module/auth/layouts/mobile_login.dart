import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/module/auth/widget/login_form.dart';
import 'package:kemerahrfrontend/share/widgets/appbar.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ""),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: LoginForm()),
      ),
    );
  }
}
