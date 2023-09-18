import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/auth/signup/signup_screen.dart';
import '../auth/login/login_screen.dart';
import 'package:mymoney/screen/home/drawer_open_.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';
import 'package:mymoney/controller/conteiner_color_change_keypade.dart';
import 'package:mymoney/data/database.dart';

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
          padding: EdgeInsets.only(top: Get.height / 3.87),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(appLogo),
              const Text(
                "Welcome to",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  fontFamily: "NunitoSemiBold",
                ),
              ),
              const Text(
                "Paper Stock",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                  fontFamily: "NunitoBold",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height / 4.81),
              ),
              loginButton(
                  textLabel: "Login",
                  onTapButton: () {
                    Get.to(LogInScreen());
                  }),
              SizedBox(
                height: Get.height / 49.52,
              ),
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
              SizedBox(
                height: Get.height / 49.52,
              ),
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
              SizedBox(
                height: Get.height / 49.52,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
