import 'package:paper_merchant/components/small_space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/screen/auth/signup/signup_screen.dart';
import '../auth/login/login_screen.dart';
import 'package:paper_merchant/screen/home/drawer_open_.dart';
import 'package:paper_merchant/utils/buttons_widget.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/utils/imagenames.dart';
import 'package:paper_merchant/controller/conteiner_color_change_keypade.dart';
import 'package:paper_merchant/data/database.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  ColorChangeController colorChangeController =
      Get.put(ColorChangeController());

  final db = Database();

  @override
  Widget build(BuildContext context) {
    var lastLoginemail = db.savedLoginEmail();
    print("========>>" + lastLoginemail);

    return Scaffold(
      backgroundColor: white,
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
              if (lastLoginemail != "")
                Padding(
                  padding: EdgeInsets.only(top: Get.height / 29.714),
                  child: Column(
                    children: [
                      const SmallSpace(),
                      loginButton(
                          textLabel: "$lastLoginemail",
                          onTapButton: () async {
                            // It does make sense to run the login and sync logic here first. and then also return True false whether it is ready for logging in.
                            bool loginReponse =
                                await db.autoLoginRememberedUser();
                            if (loginReponse) {
                              // ignore: use_build_context_synchronously
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
              const SmallSpace(),
              loginButton(
                  textLabel: lastLoginemail == "" ? "Login" : "Switch Account",
                  onTapButton: () {
                    Get.to(LogInScreen());
                  }),
              const SmallSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
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
                    child: const Text(
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

                    final loginResponse = await db.login(
                        email: "wangnelson4@gmail.com",
                        password: "test123",
                        rememberAccount: true);
                    if (loginResponse) {
                      // ignore: use_build_context_synchronously
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

                    final loginResponse = await db.login(
                        email: "caramelitogoloso2k@gmail.com",
                        password: "test123");
                    if (loginResponse) {
                      // ignore: use_build_context_synchronously
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
