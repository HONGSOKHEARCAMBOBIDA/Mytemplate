import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/core/theme/app_color.dart';
import 'package:kemerahrfrontend/core/theme/text_style.dart';
import 'package:kemerahrfrontend/share/widgets/appbar.dart';
import 'package:kemerahrfrontend/share/widgets/custombuttonnav.dart';
import 'package:kemerahrfrontend/share/widgets/loading.dart';

class MapPickerController extends GetxController {
  var latitude = RxnDouble();
  var longitude = RxnDouble();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation(); // ✅ call here instead
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          Get.snackbar("ការព្រមាន", "សូមអនុញ្ញាតទីតាំង");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("បដិសេធ", "សូមបើកក្នុង Settings");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class MapPickerView extends StatelessWidget {
  MapPickerView({Key? key}) : super(key: key);

  final controller = Get.put(MapPickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.get('background', context),
      appBar: CustomAppBar(title: "ជ្រើសទីតាំងសាខា"),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return CustomLoading();
          }

          if (controller.latitude.value == null ||
              controller.longitude.value == null) {
            return Text(
              "មិនអាចយកទីតាំងបានទេ",
              style: TextStyles.siemreap(context, fontSize: 12),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Latitude: ${controller.latitude.value}",
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              Text(
                "Longitude: ${controller.longitude.value}",
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: CustomBottomNav(
        title: "ជ្រើសទីតាំងនេះ",
        onTap: () async {
          Get.back(result: {
            'lat': controller.latitude.value,
            'lng': controller.longitude.value,
          });
        },
      ),
    );
  }
}