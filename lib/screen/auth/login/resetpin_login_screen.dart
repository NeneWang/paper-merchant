import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'email_verification_resetpin.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';
import 'package:mymoney/utils/textformfild.dart';

class RestPinEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pageBackGroundC,
        centerTitle: true,
        title: Text(
          "Forgot Pin",
          style: TextStyle(
            fontSize: 26,
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
            color: pageBackGroundC,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Enter your registrated email address to receive",
                    style: TextStyle(
                      fontSize: 15,
                      color: black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "password reset instruction",
                    style: TextStyle(
                      fontSize: 15,
                      color: black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height / 44.57),
                    child: SvgPicture.asset(
                      forgetPinBenner,
                      height: Get.height /3.87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
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
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 15.23,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height / 18.96,
                      ),
                      textFromFieldDesign(
                        hint: "Email address",
                        iconWidget: Icon(
                          Icons.email_outlined,
                          color: gray,
                        ),
                        iconWidget1: Icon(
                          Icons.visibility,
                          color: gray,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 5.94,
                      ),
                      signUpButton(
                        onTapButton: () {
                          Get.to(
                            EmailVerificationScreen(),
                          );
                        },
                        textLabel: "Reset Pin",
                      ),
                      SizedBox(
                        height: Get.height / 74.28,
                      ),
                      Text(
                        "Terms & Condition Apply",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "NunitoSemiBold",
                          color: black.withOpacity(0.6),
                        ),
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
