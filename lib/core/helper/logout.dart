import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void logout() async {
  final box = GetStorage();
  await box.erase();
  Get.offAllNamed('/login');
}
