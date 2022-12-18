import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';
import 'package:smart_admin_dashboard/services/data/repositories/log_repository.dart';
import 'package:smart_admin_dashboard/services/utils/random.dart';

class CodesController extends GetxController {
  final LogRepository repository;
  RxList<CenterModel> users = <CenterModel>[].obs;

  CodesController(this.repository);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  @override
  void onInit() {
    getCenters();
    super.onInit();
  }

  void getCenters() async {
    try {
      EasyLoading.show();
      final res = await repository.getCenters();
      users.assignAll(res);
    } on Exception catch (e) {
      Get.snackbar('Get Codes Error', e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  void addCenter() async {
    if (nameController.text.trim().isEmpty) return;
    Get.back();
    try {
      EasyLoading.show();
      final randCode = getRandomString(6);
      final center = CenterModel(
        fullname: nameController.text.trim(),
        code: randCode,
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        image: imageController.text.trim(),
        description: desController.text.trim(),
        website: websiteController.text.trim(),
      );

      await repository.addCenter(center);
      getCenters();
    } on Exception catch (e) {
      Get.snackbar('Error', 'Add Admin Error');
    }
    EasyLoading.dismiss();
  }

}
