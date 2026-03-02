import 'package:kemerahrfrontend/core/constant/api_endpoint.dart';
import 'package:kemerahrfrontend/data/models/loginmodel.dart';
import 'package:kemerahrfrontend/data/providers/api_provider.dart';

class Authservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<LoginResModel> login({
    required String username,
    required String password,
  }) async {
    final body = {'username': username, 'password': password};
    final res = await apiProvider.post(ApiEndpoint.Login, body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return LoginResModel.fromJson(res.data);
    }
    throw Exception(res.data);
  }
}
