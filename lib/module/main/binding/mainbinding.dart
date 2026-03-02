import 'package:get/get.dart';
import 'package:kemerahrfrontend/module/main/controller/maincontroller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(), fenix: true);
  }
}
