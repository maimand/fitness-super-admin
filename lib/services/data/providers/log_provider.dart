import 'package:smart_admin_dashboard/services/constants/api_constants.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/services/network_service.dart';

class LogProvider {
  final NetWorkService networkService;

  LogProvider(this.networkService);

  final String getAdminsUrl = '$baseUrl/super-admin/get-admins';
  final String getCenterUrl = '$baseUrl/super-admin/get-center';
  final String getAdminCodesUrl = '$baseUrl/super-admin/get-admin-codes';
  final String disableAdminUrl = '$baseUrl/super-admin/disable-admin';
  final String enableAdminUrl = '$baseUrl/super-admin/enable-admin';
  final String addAdminUrl = '$baseUrl/super-admin/add-admin';
  final String addCenterUrl = '$baseUrl/super-admin/add-center';
  final String deleteAdminUrl = '$baseUrl/super-admin/delete';

  Future<HttpResponse> getAdmins({int page = 1, int size = 20}) {
    return networkService.get(getAdminsUrl);
  }

  Future<HttpResponse> getCenters({int page = 1, int size = 20}) {
    return networkService.get(getCenterUrl);
  }

  Future<HttpResponse> getAdminCodes(String center,
      {int page = 1, int size = 20}) {
    return networkService.get('$getAdminCodesUrl/$center');
  }

  Future<HttpResponse> disableAdmin(String id) {
    return networkService.get('$disableAdminUrl/$id');
  }

  Future<HttpResponse> enableAdmin(String id) {
    return networkService.get('$enableAdminUrl/$id');
  }

  Future<HttpResponse> addAdmin(String centerCode, String adminName) {
    return networkService
        .post('$addAdminUrl', data: {"center": centerCode, "email": adminName});
  }

  Future<HttpResponse> addCenter(CenterModel center) {
    return networkService.post('$addCenterUrl', data: center.toJson());
  }

  Future<HttpResponse> deleteUser(
      String id,
      ) {
    return networkService.delete('$deleteAdminUrl/$id');
  }
}
