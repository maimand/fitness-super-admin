import 'package:get/get.dart';
import 'package:smart_admin_dashboard/core/constants/color_constants.dart';
import 'package:smart_admin_dashboard/core/widgets/app_button_widget.dart';
import 'package:smart_admin_dashboard/core/widgets/input_widget.dart';
import 'package:smart_admin_dashboard/screens/login/components/slider_widget.dart';

import 'package:flutter/material.dart';
import 'package:smart_admin_dashboard/services/services/auth_service.dart';

class Login extends StatefulWidget {
  Login({required this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  var tweenLeft = Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
      .chain(CurveTween(curve: Curves.ease));
  var tweenRight = Tween<Offset>(begin: Offset(0, 0), end: Offset(2, 0))
      .chain(CurveTween(curve: Curves.ease));

  AnimationController? _animationController;

  var _isMoved = false;

  bool isChecked = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.white,
                child: SliderWidget(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: bgColor,
                child: Center(
                  child: Card(
                    //elevation: 5,
                    color: bgColor,
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width / 3.6,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/logo/logo_icon.png", scale: 3),
                            SizedBox(height: 24.0),
                            Flexible(
                              child: _loginScreen(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _loginScreen(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 0.0,
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputWidget(
              keyboardType: TextInputType.emailAddress,
              kController: emailController,
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              onChanged: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },

              topLabel: "Email",

              hintText: "Enter E-mail",
              // prefixIcon: FlutterIcons.chevron_left_fea,
            ),
            SizedBox(height: 8.0),
            InputWidget(
              kController: passwordController,
              topLabel: "Password",
              obscureText: true,
              hintText: "Enter Password",
              onSaved: (String? uPassword) {},
              onChanged: (String? value) {},
              validator: (String? value) {},
            ),
            SizedBox(height: 24.0),
            AppButton(
              type: ButtonType.PRIMARY,
              text: "Sign In",
              onPressed: () {
                Get.find<AuthService>().onLogin(emailController.text.trim(),
                    passwordController.text.trim());
              },
            ),
          ],
        ),
      ),
    );
  }
}
