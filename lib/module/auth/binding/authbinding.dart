import 'package:get/get.dart';
import 'package:kemerahrfrontend/module/auth/controller/authcontroller.dart';

class Authbinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
