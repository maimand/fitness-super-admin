
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/data/providers/log_provider.dart';

class LogRepository {
  final LogProvider provider;

  LogRepository(this.provider);


  Future<List<AdminModel>> getAdmins() async {
    final response = await provider.getAdmins();
    final result = (response.body['data'] as List)
        .map((e) => AdminModel.fromJson(e))
        .toList();
    return result;
  }

  Future<List<AdminModel>> getAdminCodes() async {
    final response = await provider.getAdminCodes();
    final result = (response.body['data'] as List)
        .map((e) => AdminModel.fromJson(e))
        .toList();
    return result;
  }

  Future<void> addAdmin(String adminName) async {
    await provider.addAdmin(adminName);
  }


  Future<void> deleteUser(String id) async {
    await provider.deleteUser(id);
  }
}
