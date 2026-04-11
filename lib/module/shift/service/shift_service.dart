import 'package:kemerahrfrontend/core/constant/api_endpoint.dart';
import 'package:kemerahrfrontend/data/models/shiftmodel.dart';
import 'package:kemerahrfrontend/data/providers/api_provider.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class ShiftService {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getshift() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.ViewAllShift);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = ShiftResModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<List<Data>> getshiftbybranchid(int id) async {
    try {
      final response = await apiProvider.get(
        ApiEndpoint.ViewShfitByBranchID(id),
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final model = ShiftResModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> createshift({
    required String name,
    required int branchid,
  }) async {
    try {
      final body = {'name': name, 'branch_id': branchid};
      final response = await apiProvider.post(ApiEndpoint.AddShift, body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "បង្កេីតមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> updateshift({
    required String name,
    required int branchID,
    required int shiftid,
  }) async {
    try {
      final body = {'name': name, 'branch_id': branchID};
      final response = await apiProvider.put(
        ApiEndpoint.UpdateShift(shiftid),
        body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> changestatusshift({required int shiftid}) async {
    try {
      final response = await apiProvider.put(
        ApiEndpoint.ChangeStatusShift(shiftid),
        shiftid,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "កំហុស",
        message: "មានបញ្ហា: ${e.toString()}",
      );
      return false;
    }
  }
}
