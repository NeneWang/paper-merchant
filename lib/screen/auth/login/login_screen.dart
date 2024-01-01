import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/controller/checkbox_controller.dart';
import 'package:paper_merchant/screen/auth/forgetpassword/forgetpassword_screen.dart';
import 'package:paper_merchant/screen/auth/signup/signup_screen.dart';
import 'package:paper_merchant/controller/conteiner_color_change_keypade.dart';
import 'package:paper_merchant/screen/home/drawer_open_.dart';
import 'package:paper_merchant/utils/buttons_widget.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/utils/imagenames.dart';
import 'package:paper_merchant/utils/textformfild.dart';
import 'package:paper_merchant/data/database.dart';

// ignore: must_be_immutable
class LogInScreen extends StatelessWidget {
  CheckBoxController checkBoxController = Get.put(CheckBoxController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ColorChangeController colorChangeController =
      Get.put(ColorChangeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      body: Stack(
        children: [
          Container(
            color: pageBackGroundC,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: Get.height / 14),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26,
                        color: black,
                        fontFamily: "NunitoBold",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height / 29.714),
                      child: SvgPicture.asset(
                        loginBenner,
                        height: Get.height / 3.56,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height / 2.20),
            child: Container(
              height: Get.height / 1.7,
              width: Get.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 15.23,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height / 17.47,
                      ),
                      inputFieldCustom(
                          hint: "Email", textController: emailController),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      inputfieldDesignPassword(
                        hint: "Password",
                        textController: passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => Checkbox(
                              value: checkBoxController.isCheck.value,
                              activeColor: appColor,
                              onChanged: (val) {
                                checkBoxController.isCheck.value =
                                    !checkBoxController.isCheck.value;
                              },
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: black.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: "MontserratRegular",
                            ),
                          ),
                          SizedBox(
                            width: 30 /*tablet:110*/,
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                ForGetPassword(),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: black.withOpacity(0.6),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: "MontserratRegular",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height / 16.20,
                      ),
                      loginButton(
                        onTapButton: () {
                          Database db = Database();
                          db.login(email: '', password: '');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrawerOpenScreen(),
                            ),
                          );

                          // Get.to(
                          //   VerificationScreen(),
                          // );
                        },
                        textLabel: "Log In",
                      ),
                      SizedBox(
                        height: Get.height / 74.28,
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
                              Get.to(
                                SignUpScreen(),
                              );
                              print("Sign Up");
                            },
                            child: Text(
                              "Sign up",
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
            ),
          ),
        ],
      ),
    );
  }
}
