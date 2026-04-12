import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemerahrfrontend/data/models/shiftsessionmodel.dart';
import 'package:kemerahrfrontend/module/shiftsession/service/shiftsession_service.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class ShiftsessionController extends GetxController {
  final ShiftsessionService shiftsessionService = ShiftsessionService();
  var shiftsession = <Data>[].obs;
  var isLoading = false.obs;
  final nameController = TextEditingController();
  var selectshiftid = RxnInt();
  final selectedStartTime = Rxn<TimeOfDay>();
  final selectedEndTime = Rxn<TimeOfDay>();
  var editingIndex = RxnInt();
  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  void startEdit(int index, shiftsession) {
    editingIndex.value = index;
    nameController.text = shiftsession.sessionName ?? '';
    selectshiftid.value = shiftsession.shiftId ?? '';
    selectedStartTime.value = shiftsession.startTime ?? '';
    selectedEndTime.value = shiftsession.endTime ?? '';
  }

  void cancelEdit() {
    editingIndex.value = null;
  }

  Future<void> saveEdit(shiftsession) async {
    await updateshiftsession(
      id: shiftsession.id!,
      name: nameController.text,
      starttime: formatTime(selectedStartTime.value!),
      endtime: formatTime(selectedEndTime.value!),
    );
    editingIndex.value = null;
  }

  Future<void> fetchshiftsessionbyshiftid(int id) async {
    try {
      final result = await shiftsessionService.getshiftsessionbyshiftid(id);
      shiftsession.clear();
      shiftsession.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createshiftsession({
    required String name,
    required int shiftid,
    required String starttime,
    required String endtime,
  }) async {
    try {
      isLoading.value = true;
      bool created = await shiftsessionService.createshiftsession(
        name: name,
        shiftid: shiftid,
        starttime: starttime,
        endtime: endtime,
      );
      if (created) {
        //shiftsession.clear();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateshiftsession({
    required int id,
    required String name,
    required String starttime,
    required String endtime,
  }) async {
    try {
      isLoading.value = true;
      bool updated = await shiftsessionService.updateshiftsession(
        id: id,
        name: name,
        starttime: starttime,
        endtime: endtime,
      );
      if (updated) {
        CustomSnackbar.success(title: "ជោគជ័យ", message: "កែប្រែបានជោគជ័យ");
        Get.back();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusshiftsession({required int id}) async {
    try {
      isLoading.value = true;
      bool updated = await shiftsessionService.changestatusshiftsession(id: id);
      if (updated) {}
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
