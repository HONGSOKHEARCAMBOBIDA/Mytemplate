import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/module/auth/widget/login_form.dart';

class TabletLogin extends StatelessWidget {
  const TabletLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
