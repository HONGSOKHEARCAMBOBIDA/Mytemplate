import 'package:flutter/material.dart';
import 'package:kemerahrfrontend/module/auth/layouts/desktop_login.dart';
import 'package:kemerahrfrontend/module/auth/layouts/mobile_login.dart';
import 'package:kemerahrfrontend/module/auth/layouts/tablet_login.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) {
      return const MobileLogin();
    }

    if (ResponsiveBreakpoints.of(context).isTablet) {
      return const TabletLogin();
    }

    return const DesktopLogin();
  }
}
