import 'package:get/get.dart';
import 'package:kemerahrfrontend/core/constant/message.dart';
import 'package:kemerahrfrontend/module/auth/service/authservice.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kemerahrfrontend/module/main/binding/mainbinding.dart';
import 'package:kemerahrfrontend/module/main/view/mainview.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class AuthController extends GetxController {
  final Authservice authservice = Authservice();

  var isLoading = false.obs;
  final GetStorage box = GetStorage();

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final res = await authservice.login(
        username: username,
        password: password,
      );

      if (res.data?.token != null && res.data!.token!.isNotEmpty) {
        await box.write('token', res.data!.token);
        await box.write('roleid', res.data!.roleId);

        CustomSnackbar.success(
          title: Message.Success,
          message: Message.LoginSuccess,
        );
        Get.offAll(()=> MainView(),binding: MainBinding());
      } else {
        CustomSnackbar.error(title: Message.Error, message: Message.LoginError);
      }
    } catch (e) {
      CustomSnackbar.error(title: Message.Error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
