import 'package:kemerahrfrontend/core/constant/api_endpoint.dart';
import 'package:kemerahrfrontend/data/models/branchmodel.dart';
import 'package:kemerahrfrontend/data/providers/api_provider.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class Branchservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getbranch() async {
    try {
      final response = await apiProvider.get(ApiEndpoint.ViewBranch);
      if (response.statusCode == 200) {
        final json = response.data;
        final model = BranchResModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> createbranch({
    required String name,
    required String latitude,
    required String longitude,
    required int radius,
  }) async {
    try {
      final body = {
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'radius': radius,
      };
      final response = await apiProvider.post(ApiEndpoint.AddBranch, body);
      if (response.statusCode == 200) {
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

  Future<bool> updatebranch({
    required String name,
    required String latitude,
    required String longitude,
    required int radius,
    required int branchID,
  }) async {
    try {
      final body = {
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'radius': radius,
      };
      final response = await apiProvider.put(
        ApiEndpoint.UpdateBranch(branchID),
        body,
      );
      if (response.statusCode == 200) {
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

  Future<bool> changestatusbranch({required int branchid}) async {
    try {
      final response = await apiProvider.put(
        ApiEndpoint.ChangeStatusBranch(branchid),
        branchid,
      );
      if (response.statusCode == 200) {
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
