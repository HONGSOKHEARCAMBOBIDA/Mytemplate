import 'package:get/get.dart';
import 'package:kemerahrfrontend/module/auth/binding/authbinding.dart';
import 'package:kemerahrfrontend/module/auth/view/login.dart';
import 'package:kemerahrfrontend/module/main/binding/mainbinding.dart';
import 'package:kemerahrfrontend/module/main/middleware/mainmiddleware.dart';
import 'package:kemerahrfrontend/module/main/view/mainview.dart';

class Managepage {
  static const INITIAL = '/main';
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginView(),
      bindings: [Authbinding()],
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/main', 
      middlewares: [Mainmiddleware()],
      page: () => MainView(),
      binding: MainBinding(),
      
      )
  ];
}
