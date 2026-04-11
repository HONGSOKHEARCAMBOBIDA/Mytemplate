import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/data/models/shiftmodel.dart';
import 'package:kemerahrfrontend/module/shift/service/shift_service.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class ShiftController extends GetxController {
  final ShiftService shiftService = ShiftService();
  var shift = <Data>[].obs;
  var isLoading = false.obs;
  final nameController = TextEditingController();
  final selectbranchid = Rxn<int>();
  var editingIndex = RxnInt();
  @override
  void onInit() {
    fetchshift(); // Fetch all roles by default
    super.onInit();
  }

  void startEdit(int index, shift) {
    editingIndex.value = index;
    nameController.text = shift.name ?? '';
    selectbranchid.value = shift.branchId ?? '';
  }

  void cancelEdit() {
    editingIndex.value = null;
  }

  Future<void> saveEdit(shift) async {
    await updateshift(
      name: nameController.text,
      branchid: selectbranchid.value!,
      shiftid: shift.id!,
    );
    editingIndex.value = null;
  }

  Future<void> fetchshift() async {
    try {
      final result = await shiftService.getshift();
      shift.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> fetchshiftbybranchid(int id) async {
    try {
      final result = await shiftService.getshiftbybranchid(id);
      shift.clear();
      shift.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createshift({
    required String name,
    required int branchid,
  }) async {
    try {
      isLoading.value = true;
      bool created = await shiftService.createshift(
        name: name,
        branchid: branchid,
      );
      if (created) {
        shift.clear();
        fetchshift();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateshift({
    required String name,
    required int branchid,
    required int shiftid,
  }) async {
    try {
      isLoading.value = true;
      bool updated = await shiftService.updateshift(
        name: name,
        branchID: branchid,
        shiftid: shiftid,
      );
      if (updated) {
        shift.clear();
        Get.back();
        await fetchshift();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusshift({required int shiftid}) async {
    try {
      isLoading.value = true;
      bool updated = await shiftService.changestatusshift(shiftid: shiftid);
      if (updated) {
        shift.clear();
        await fetchshift();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
