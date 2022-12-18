
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

  Future<List<CenterModel>> getCenters() async {
    final response = await provider.getCenters();
    final result = (response.body['data'] as List)
        .map((e) => CenterModel.fromJson(e))
        .toList();
    return result;
  }

  Future<List<String>> getAdminCodes(String center) async {
    final response = await provider.getAdminCodes(center);
    final result = (response.body['data'] as List)
        .map((e) => e['email'] as String)
        .toList();
    return result;
  }

  Future<void> addAdmin(String centerCode, String adminEmail) async {
    await provider.addAdmin(centerCode, adminEmail);
  }

  Future<void> addCenter(CenterModel centerModel) async {
    await provider.addCenter(centerModel);
  }

  Future<void> disableAdmin(String id) async {
    await provider.disableAdmin(id);
  }

  Future<void> enableAdmin(String id) async {
    await provider.enableAdmin(id);
  }

  Future<void> deleteUser(String id) async {
    await provider.deleteUser(id);
  }
}
