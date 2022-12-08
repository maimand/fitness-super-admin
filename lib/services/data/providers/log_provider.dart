import 'package:smart_admin_dashboard/services/constants/api_constants.dart';
import 'package:smart_admin_dashboard/services/services/network_service.dart';

class LogProvider {
  final NetWorkService networkService;

  LogProvider(this.networkService);

  final String getAdminsUrl = '$baseUrl/super-admin/get-admins';
  final String getAdminCodesUrl = '$baseUrl/super-admin/get-admin-codes';
  final String deleteAdminUrl = '$baseUrl/super-admin/delete';
  final String addAdminUrl = '$baseUrl/super-admin/add-admin';


  Future<HttpResponse> getAdmins(
      {int page = 1, int size = 20}) {
    return networkService.get(getAdminsUrl);
  }

  Future<HttpResponse> getAdminCodes(
      {int page = 1, int size = 20}) {
    return networkService.get(getAdminCodesUrl);
  }

  Future<HttpResponse> deleteUser(
    String id,
  ) {
    return networkService.delete('$deleteAdminUrl/$id');
  }

  Future<HttpResponse> addAdmin(String adminName) {
    return networkService.post('$addAdminUrl/$adminName');
  }

}
