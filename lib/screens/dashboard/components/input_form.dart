import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/screens/dashboard/controllers/center_controller.dart';
import 'package:smart_admin_dashboard/services/data/models/user.model.dart';

class FormMaterial extends StatelessWidget {
  final CenterModel center;

  const FormMaterial({Key? key, required this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CenterController(Get.find(), center));
    return Scaffold(
        appBar: new AppBar(
          leading: BackButton(
            onPressed: () {
              Get.back();
              controller.dispose();
            },
          ),
          title: Text(
            "${center.fullname}",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (center.image != null) Image.network(center.image!),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Center Name: ${center.fullname}"),
                      const SizedBox(height: 8),
                      Text("Email: ${center.email}"),
                      const SizedBox(height: 8),
                      Text("Phone: ${center.phone}"),
                      const SizedBox(height: 8),
                      Text("Description: ${center.description}"),
                      const SizedBox(height: 8),
                      Text("Website: ${center.website}"),
                      const SizedBox(height: 8),
                      Text('Admin Whitelist:'),
                      const SizedBox(height: 8),
                      ...controller.emails.map((element) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('- $element'),
                          )),
                      TextButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (context) => new AlertDialog(
                                contentPadding: const EdgeInsets.all(16.0),
                                content: new Row(
                                  children: <Widget>[
                                    new Expanded(
                                      child: new TextField(
                                        controller: controller.emailController,
                                        autofocus: true,
                                        decoration: new InputDecoration(
                                            labelText: 'Full Name',
                                            hintText: 'eg. John Smith'),
                                      ),
                                    )
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
                                        controller.addEmailForCenter();
                                      })
                                ],
                              ),
                            );
                          },
                          child: Text('Add email'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
