import 'package:get/get.dart';
import 'package:kemerahrfrontend/module/auth/binding/authbinding.dart';
import 'package:kemerahrfrontend/module/auth/view/login.dart';

class Managepage {
  static const INITIAL = '/login';
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginView(),
      bindings: [Authbinding()],
      transition: Transition.fadeIn,
    ),
  ];
}
