import 'package:smart_admin_dashboard/services/constants/api_constants.dart';
import 'package:smart_admin_dashboard/services/services/network_service.dart';

class AuthProvider {
  final NetWorkService networkService;

  AuthProvider(this.networkService);

  final String loginUrl = '$baseUrl/super-admin/login';


  Future<HttpResponse> login(String username, String password) {
    return networkService
        .post(loginUrl, data: {"username": username, "password": password});
  }

}
