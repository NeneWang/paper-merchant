import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:papermarket/controller/conteiner_color_change_keypade.dart';
import 'package:papermarket/screen/auth/forgetpassword/change_password_screen.dart';
import 'package:papermarket/utils/color.dart';
import 'package:papermarket/utils/imagenames.dart';
import 'package:papermarket/utils/round_container.dart';
import 'package:papermarket/utils/textformfild.dart';

class EmailVerificationForgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorChangeController colorChangeController =
        Get.put(ColorChangeController());

    return Scaffold(
      backgroundColor: pageBackGroundC,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pageBackGroundC,
        centerTitle: true,
        title: Text(
          "Email Verification",
          style: TextStyle(
            fontSize: 25,
            color: black,
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
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Enter your registrated email address to receive",
              style: TextStyle(
                fontSize: 15,
                color: black2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "test001@gmail.com",
              style: TextStyle(
                fontSize: 15,
                color: black2,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: Get.height / 11.72,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                roundContainer(
                  textNum: "6",
                  colorBox: white,
                  colorBorder: green,
                ),
                /*SizedBox(
                  width: 16,
                ),
                roundContainer(
                  colorBox: gray3,
                ),
                SizedBox(
                  width: 16,
                ),
                roundContainer(
                  colorBox: gray3,
                ),
                SizedBox(
                  width: 16,
                ),
                roundContainer(
                  colorBox: gray3,
                ),*/
              ],
            ),
            SizedBox(
              height: Get.height / 24.09,
            ),
            InkWell(
              onTap: () {
                Get.to(
                  ChangePasswordScreen(),
                );
              },
              child: Container(
                height: Get.height / 17.82,
                width: Get.width / 8.22,
                decoration: BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: white,
                  size: Get.height / 29.71,
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 26.21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If You Didn’t Received Code?",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "NunitoSemiBold",
                    color: black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("Sign Up");
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontSize: 15,
                      color: appColor,
                      fontFamily: "NunitoBold",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height / 29.714,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 7.62, vertical: Get.height / 50.93),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange1(true);
                        insertText("1");
                      },
                      child: textForKeypad(
                          "1",
                          colorChangeController.isChange1.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange(true);
                        insertText("2");
                      },
                      child: textForKeypad(
                          "2",
                          colorChangeController.isChange.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange2(true);
                        insertText("3");
                      },
                      child: textForKeypad(
                        "3",
                        colorChangeController.isChange2.isTrue
                            ? white
                            : transPrent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 7.62, vertical: Get.height / 50.93),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange3(true);
                        insertText("4");
                      },
                      child: textForKeypad(
                          "4",
                          colorChangeController.isChange3.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange4(true);
                        insertText("5");
                      },
                      child: textForKeypad(
                          "5",
                          colorChangeController.isChange4.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange5(true);
                        insertText("6");
                      },
                      child: textForKeypad(
                          "6",
                          colorChangeController.isChange5.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 7.62, vertical: Get.height / 50.93),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange6(true);
                        insertText("7");
                      },
                      child: textForKeypad(
                          "7",
                          colorChangeController.isChange6.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange7(true);
                        insertText("8");
                      },
                      child: textForKeypad(
                          "8",
                          colorChangeController.isChange7.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange8(true);
                        insertText("9");
                      },
                      child: textForKeypad(
                          "9",
                          colorChangeController.isChange8.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 7.62, vertical: Get.height / 50.93),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange9(true);
                        insertText(".");
                      },
                      child: Container(
                        height: Get.height / 14.37,
                        width: Get.width / 6.63,
                        decoration: BoxDecoration(
                          color: colorChangeController.isChange9.isTrue
                              ? white
                              : transPrent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            ".",
                            style: TextStyle(
                              color: black,
                              fontSize: 36,
                              fontFamily: "NunitoSemiBold",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  /*Text(
                    ".",
                    style: TextStyle(
                      color: black,
                      fontSize: 36,
                      fontFamily: "NunitoSemiBold",
                      fontWeight: FontWeight.w400,
                    ),
                  ),*/
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange10(true);
                        insertText("0");
                      },
                      child: textForKeypad(
                          "0",
                          colorChangeController.isChange10.isTrue
                              ? white
                              : transPrent),
                    ),
                  ),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange11(true);
                        backspace();
                      },
                      child: Container(
                        height: Get.height / 14.37,
                        width: Get.width / 6.63,
                        decoration: BoxDecoration(
                          color: colorChangeController.isChange11.isTrue
                              ? white
                              : transPrent,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            arrowRemove,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
