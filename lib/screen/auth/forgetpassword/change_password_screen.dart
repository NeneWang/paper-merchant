import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:papermarket/screen/auth/login/login_screen.dart';
import 'package:papermarket/utils/buttons_widget.dart';
import 'package:papermarket/utils/color.dart';
import 'package:papermarket/utils/textformfild.dart';

class ChangePasswordScreen extends StatelessWidget {
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
          "Change Password",
          style: TextStyle(
            fontSize: 25,
            color: black1,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w600,
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
      body: Padding(
        padding: EdgeInsets.only(top: Get.height / 17.82),
        child: Container(
          height: Get.height / 1.17,
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
                  horizontal: Get.width / 17.14, vertical: Get.height / 25.46),
              child: Column(
                children: [
                  inputFieldCustom(
                    hint: "New password",
                  ),
                  SizedBox(
                    height: Get.height / 22.28,
                  ),
                  inputFieldCustom(
                    hint: "Repeat password",
                  ),
                  SizedBox(
                    height: Get.height / 12.73,
                  ),
                  resetButton(
                    textLabel: "Change Password",
                    onTapButton: () {
                      Get.off(
                        LogInScreen(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
