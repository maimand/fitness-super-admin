import 'package:get/get.dart';
import 'package:smart_admin_dashboard/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/codes_screen.dart';
import 'package:smart_admin_dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/home/home_controller.dart';

import 'components/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return SelectionArea(
      child: Scaffold(
        //key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Obx(
                () => Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: controller.currentPage.value == 0
                      ? DashboardScreen()
                      : CodesScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
