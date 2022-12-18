import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/data/repositories/log_repository.dart';

class CenterController extends GetxController {
  final LogRepository repository;
  final CenterModel center;

  RxList<String> emails = <String>[].obs;

  CenterController(this.repository, this.center);

  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    getAdminWhitelist();
    super.onInit();
  }

  void getAdminWhitelist() async {
    try {
      EasyLoading.show();
      final res = await repository.getAdminCodes(center.code ?? '');
      emails.assignAll(res);
    } on Exception catch (e) {
      Get.snackbar('Error', 'Get Whitelist Error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void addEmailForCenter() async {
    if (emailController.text.trim().isEmpty) return;
    Get.back();
    try {
      EasyLoading.show();
      await repository.addAdmin(center.code ?? '', emailController.text.trim());
      getAdminWhitelist();
    } on Exception catch (e) {
      Get.snackbar('Add Email for Center Error', e.toString());
    }
    EasyLoading.dismiss();
  }

}
