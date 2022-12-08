
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/data/providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider provider;

  AuthRepository(this.provider);

  Future<LoginResult> login(String username, password) async {
    final response = await provider.login(username, password);
    final result = LoginResult.fromJson(response.body);
    return result;
  }

}
