import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/data/repositories/log_repository.dart';

class DashboardController extends GetxController {
  final LogRepository repository;
  RxList<AdminModel> users = <AdminModel>[].obs;

  DashboardController(this.repository);

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    try {
      EasyLoading.show();
      final res = await repository.getAdmins();
      users.assignAll(res);
    } on Exception catch (e) {
      Get.snackbar('Get Admins Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void disableAdmin(AdminModel user) async {
    try {
      await repository.disableAdmin(user.email ?? '');
      getUsers();
    } on Exception catch (e) {
      Get.snackbar('Disable Admins Error', e.toString());
    }
  }

  void enableAdmin(AdminModel user) async {
    try {
      await repository.enableAdmin(user.email ?? '');
      getUsers();
    } on Exception catch (e) {
      Get.snackbar('Enable Admins Error', e.toString());
    }
  }

  void deleteUser(AdminModel user) async {
    try {
      await repository.deleteUser(user.id!);
      getUsers();
    } on Exception catch (e) {
      Get.snackbar('Delete Admins Error', e.toString());
    }
  }

}