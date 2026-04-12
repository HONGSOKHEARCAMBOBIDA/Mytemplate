import 'package:kemerahrfrontend/core/constant/api_endpoint.dart';
import 'package:kemerahrfrontend/data/models/shiftsessionmodel.dart';
import 'package:kemerahrfrontend/data/providers/api_provider.dart';
import 'package:kemerahrfrontend/share/widgets/snackbar.dart';

class ShiftsessionService {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getshiftsessionbyshiftid(int id) async {
    try {
      final response = await apiProvider.get(
        ApiEndpoint.ViewShiftSessionByShiftID(id),
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final model = ShiftSessionResModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<bool> createshiftsession({
    required String name,
    required int shiftid,
    required String starttime,
    required String endtime,
  }) async {
    try {
      final body = {
        'session_name': name,
        'shift_id': shiftid,
        'start_time': starttime,
        'end_time': endtime,
      };
      final response = await apiProvider.post(
        ApiEndpoint.AddShiftSession,
        body,
      );
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

  Future<bool> updateshiftsession({
    required int id,
    required String name,
    required String starttime,
    required String endtime,
  }) async {
    try {
      final body = {
        'session_name': name,
        'start_time': starttime,
        'end_time': endtime,
      };
      final response = await apiProvider.put(
        ApiEndpoint.UpdateShiftSession(id),
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

  Future<bool> changestatusshiftsession({required int id}) async {
    try {
      final response = await apiProvider.put(
        ApiEndpoint.ChangeStatusShiftSession(id),
        id,
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
