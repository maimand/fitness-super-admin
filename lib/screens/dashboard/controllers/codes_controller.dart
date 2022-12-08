import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/data/repositories/log_repository.dart';

class CodesController extends GetxController {
  final LogRepository repository;
  RxList<AdminModel> users = <AdminModel>[].obs;

  CodesController(this.repository);

  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    try {
      EasyLoading.show();
      final res = await repository.getAdminCodes();
      users.assignAll(res);
    } on Exception catch (e) {
      Get.snackbar('Get Codes Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void addAdmin() async {
    if (nameController.text.trim().isEmpty) return;
    Get.back();
    try {
      EasyLoading.show();
      await repository.addAdmin(nameController.text.trim());
      getUsers();
    } on Exception catch (e) {
      Get.snackbar('Add Admin Error', e.toString());
    }
    EasyLoading.dismiss();

  }
}
