import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/controller/conteiner_color_change_keypade.dart';
import 'package:mymoney/screen/auth/forgetpassword/change_password_screen.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';
import 'package:mymoney/utils/round_container.dart';
import 'package:mymoney/utils/textformfild.dart';

// ignore: must_be_immutable
class ResetNewPinScreen extends StatelessWidget {
  ColorChangeController colorChangeController =
      Get.put(ColorChangeController());

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
          "Enter PIN",
          style: TextStyle(
            fontSize: 26,
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
              "Enhance the security of your account by",
              style: TextStyle(
                fontSize: 15,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "creating a PIN code",
              style: TextStyle(
                fontSize: 15,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 76,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                roundContainer(
                  textNum: "5",
                  textColor: appColor,
                  colorBox: white,
                  colorBorder: green,
                ),
               /* SizedBox(
                  width: 16,
                ),
                roundContainer(
                  colorBox: gray2,
                ),
                SizedBox(
                  width: 16,
                ),
                roundContainer(
                  colorBox: gray2,
                ),
                SizedBox(
                  width: 16,
                ),
                roundContainer(
                  colorBox: gray2,
                ),*/
              ],
            ),
            SizedBox(
              height: 37,
            ),
            InkWell(
              onTap: () {
                Get.to(
                  ChangePasswordScreen(),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: white,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 34,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 54, vertical: 17.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange1(true);
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
              padding: EdgeInsets.symmetric(horizontal: 54, vertical: 17.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange3(true);
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
              padding: EdgeInsets.symmetric(horizontal: 54, vertical: 17.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange6(true);
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
              padding: EdgeInsets.symmetric(horizontal: 54, vertical: 17.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange9(true);
                      },
                      child: Container(
                        height: 62,
                        width: 62,
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
                  Obx(
                    () => InkWell(
                      onTap: () {
                        condition();
                        colorChangeController.isChange10(true);
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
                      },
                      child: Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                          color: colorChangeController.isChange11.isTrue
                              ? white
                              : transPrent,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(arrowRemove),
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
