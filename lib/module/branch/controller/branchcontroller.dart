import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/data/models/branchmodel.dart';
import 'package:kemerahrfrontend/module/branch/service/branchservice.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class Branchcontroller extends GetxController {
  final Branchservice branchservice = Branchservice();
  var branch = <Data>[].obs;
  var isLoading = false.obs;
  final nameController = TextEditingController();
final latController = TextEditingController();
final lngController = TextEditingController();
final radiusController = TextEditingController();
var editingIndex = RxnInt(); // nullable int
  @override
  void onInit() {
    fetchbranch(); // Fetch all roles by default
    super.onInit();
  }

  void startEdit(int index, branch) {
  editingIndex.value = index;

  nameController.text = branch.name ?? '';
  latController.text = branch.latitude ?? '';
  lngController.text = branch.longitude ?? '';
  radiusController.text = branch.radius?.toString() ?? '';
}

void cancelEdit() {
  editingIndex.value = null;
}
Future<void> saveEdit(branch) async {
  await updatebranch(
    branchid: branch.id!,
    name: nameController.text,
    latitude: latController.text,
    longitude: lngController.text,
    radius: int.parse(radiusController.text),
  );

  editingIndex.value = null;
}

  Future<void> fetchbranch() async {
    try {
      final result = await branchservice.getbranch();
      branch.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createbranch({
    required String name,
    required String latitude,
    required String longitude,
    required int radius,
  }) async {
    try {
      isLoading.value = true;
      bool created = await branchservice.createbranch(
        name: name,
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      if (created) {
        branch.clear();
       fetchbranch();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatebranch({
    required String name,
    required String latitude,
    required String longitude,
    required int radius,
    required int branchid,
  }) async {
    try {
      isLoading.value = true;
      bool updated = await branchservice.updatebranch(
        name: name,
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        branchID: branchid,
      );
      if (updated) {
        Get.back();
        await fetchbranch();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusbranch({required int branchid}) async {
    try {
      isLoading.value = true;
      bool updated = await branchservice.changestatusbranch(branchid: branchid);
      if (updated) {
        await fetchbranch();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
