import 'package:get/get.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/responsive.dart';
import 'package:smart_admin_dashboard/screens/dashboard/components/input_form.dart';
import 'package:smart_admin_dashboard/screens/dashboard/controllers/codes_controller.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';

class RecentCodes extends StatelessWidget {
  const RecentCodes({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CodesController>();
    controller.getCenters();
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Codes",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ElevatedButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (context) => new AlertDialog(
                        contentPadding: const EdgeInsets.all(16.0),
                        content:  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: controller.nameController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Full Name', hintText: 'eg. John Smith'),
                            ),
                            TextField(
                              controller: controller.emailController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Email', hintText: 'email@gmail.com'),
                            ),
                            TextField(
                              controller: controller.phoneController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Phone', hintText: '012345678'),
                            ),
                            TextField(
                              controller: controller.desController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Description', hintText: 'Wonderful center'),
                            ),
                            TextField(
                              controller: controller.imageController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Image', hintText: 'url'),
                            ),
                            TextField(
                              controller: controller.websiteController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Website', hintText: 'url'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          new TextButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          new TextButton(
                              child: const Text('ADD'),
                              onPressed: () {
                                controller.addCenter();
                              })
                        ],
                      ),
                    );
                },
                icon: Icon(Icons.add),
                label: Text(
                  "Add New",
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () => DataTable(
                  horizontalMargin: 0,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Code"),
                    ),
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Email"),
                    ),
                  ],
                  rows: List.generate(
                    controller.users.length,
                    (index) =>
                        recentUserDataRow(controller.users[index], context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserDataRow(CenterModel userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            TextAvatar(
              size: 35,
              backgroundColor: Colors.white,
              textColor: Colors.white,
              fontSize: 14,
              upperCase: true,
              numberLetters: 1,
              shape: Shape.Rectangle,
              text: userInfo.fullname!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                userInfo.fullname!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(
        Text(
          userInfo.code ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DataCell(
        Text(
          userInfo.fullname ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DataCell(
        Row(
          children: [Text(
            userInfo.email ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
            const Spacer(),
            TextButton(
              child: Text("View", style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new FormMaterial(center: userInfo);
                    },
                    fullscreenDialog: true));

              },
              // Delete
            ),

          ]
        ),
      ),
    ],
  );
}
