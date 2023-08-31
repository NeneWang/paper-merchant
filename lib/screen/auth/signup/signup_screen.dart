import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/auth/login/login_screen.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';
import 'package:mymoney/utils/textformfild.dart';

import 'creatpin_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pageBackGroundC,
        centerTitle: true,
        title: Text(
          "Create Account",
          style: TextStyle(
            fontSize: 25,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: black1,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: pageBackGroundC,
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 23.45),
              child: SvgPicture.asset(signUPBenner, height: Get.height / 4.43),
            ),
          ),
          Positioned(
            top: Get.height / 3.71,
            bottom: 0.0,
            child: Container(
              height: Get.height / 1.59,
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
                    horizontal: Get.width / 17.14,
                    vertical: Get.height / 22.28),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      textFromFieldDesign1(
                        hint: "First Name",
                        iconWidget: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            user,
                            color: gray9B9797,
                          ),
                        ),
                        iconWidget1: Icon(
                          Icons.visibility_outlined,
                          color: gray9B9797,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      textFromFieldDesign1(
                        hint: "Last Name",
                        iconWidget: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            user,
                            color: gray9B9797,
                          ),
                        ),
                        iconWidget1: Icon(
                          Icons.visibility_outlined,
                          color: gray9B9797,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      textFromFieldDesign1(
                        hint: "Email",
                        iconWidget: Icon(
                          Icons.email_outlined,
                          color: gray9B9797,
                          size: 27,
                        ),
                        iconWidget1: Icon(
                          Icons.visibility_outlined,
                          color: gray9B9797,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      textFromFieldDesign1(
                        hint: "Password",
                        iconWidget: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            lockIcon,
                            color: gray9B9797,
                          ),
                        ),
                        iconWidget1: Icon(
                          Icons.visibility_outlined,
                          color: gray9B9797,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 17.82,
                      ),
                      signUpButton(
                        textLabel: "Sign Up",
                        onTapButton: () {
                          Get.to(
                            CreatePinScreen(),
                          );
                        },
                      ),
                      SizedBox(
                        height: Get.height / 55.71,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Nunito",
                              color: black485068,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(
                                LogInScreen(),
                              );
                              print("Sign Up");
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 15,
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
