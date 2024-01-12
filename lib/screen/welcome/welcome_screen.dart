import 'package:papermarket/components/small_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:papermarket/screen/auth/signup/signup_screen.dart';
import '../auth/login/login_screen.dart';
import 'package:papermarket/screen/home/drawer_open_.dart';
import 'package:papermarket/utils/buttons_widget.dart';
import 'package:papermarket/utils/color.dart';
import 'package:papermarket/utils/imagenames.dart';
import 'package:papermarket/controller/conteiner_color_change_keypade.dart';
import 'package:papermarket/data/database.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  ColorChangeController colorChangeController =
      Get.put(ColorChangeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appLogo,
                height: Get.height / 4.95,
                width: Get.width / 2.76,
              ),
              Padding(padding: EdgeInsets.only()),
              const Text(
                "Paper Merchant",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                  fontFamily: "NunitoBold",
                ),
              ),
              const SmallSpace(),
              loginButton(
                  textLabel: "Login",
                  onTapButton: () {
                    Get.to(LogInScreen());
                  }),
              const SmallSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Nunito",
                      color: black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(
                        fontSize: 14,
                        color: appColor,
                        fontFamily: "NunitoSemiBold",
                      ),
                    ),
                  ),
                ],
              ),
              const SmallSpace(),
              loginButton(
                  textLabel: "Login as Demo",
                  onTapButton: () async {
                    // It does make sense to run the login and sync logic here first. and then also return True false whether it is ready for logging in.
                    final Database db = Database();
                    final loginResponse = await db.login(
                        email: "wangnelson4@gmail.com", password: "test123");
                    if (loginResponse) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrawerOpenScreen(),
                        ),
                      );
                    }
                  }),
              loginButton(
                  textLabel: "Login as Demo2",
                  onTapButton: () async {
                    // It does make sense to run the login and sync logic here first. and then also return True false whether it is ready for logging in.
                    final Database db = Database();
                    final loginResponse = await db.login(
                        email: "caramelitogoloso2k@gmail.com",
                        password: "test123");
                    if (loginResponse) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrawerOpenScreen(),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
