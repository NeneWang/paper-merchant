import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/controller/checkbox_controller.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'verify_pin_screen_account.dart';

// ignore: must_be_immutable
class PhoneVerifyScreen extends StatelessWidget {
  FocusNode _focusNode = new FocusNode();
  CheckBoxController checkBoxController = Get.find();

  @override
  Widget build(BuildContext context) {
    print("vvehveh${_focusNode.hasFocus}");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            CupertinoIcons.back,
            color: black,
          ),
        ),
        elevation: 0,
        backgroundColor: pageBackGroundC,
        centerTitle: true,
        title: Text(
          "Verify Number",
          style: TextStyle(
            fontSize: 25,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: pageBackGroundC,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 34.28),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => new LinearPercentIndicator(
                          width: 220,
                          animation: true,
                          lineHeight: 5.0,
                          // animationDuration: 1000,
                          percent: checkBoxController.isSelected.isTrue == true
                              ? 0.5
                              : 0.2,
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: appColor,
                          addAutomaticKeepAlive: true,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 20),
                    child: Container(
                      height: 48,
                      width: 327,
                      child: Text(
                        "Please enter your country and your phone number to receive a verification code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: black485068,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height / 40),
                    child: Image.asset(
                      phoneVerifyBenner,
                      height: Get.height > 750 ? Get.height / 3.44 : 200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height > 750 ? 360 : 315),
            child: Container(
              height: 440,
              width: Get.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 11.75),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 49, bottom: 10),
                        child: Container(
                          height: 46,
                          padding: EdgeInsets.all(13),
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: grayD5DDE0.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            focusNode: _focusNode,
                            cursorColor: appColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: -2),
                              border: InputBorder.none,
                              hintText: "Enter Mobile Number",
                              isDense: true,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: black2.withOpacity(0.6),
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w600,
                              ),
                              prefixIcon: Container(
                                width: 20,
                                child: Row(
                                  children: [
                                    Text(
                                      "+218",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: black2,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 4,
                                      ),
                                      child: Container(
                                        height: 20,
                                        width: 1,
                                        child: VerticalDivider(
                                          color: black.withOpacity(0.6),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              suffixIcon: SvgPicture.asset(smartphone),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        child: Column(
                          children: [
                            Text(
                              "By continuing, I confirm that i have read & agree to the",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff898989),
                                fontFamily: "Nunito",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Terms & conditions",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " and ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff898989),
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy policy",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: black,
                                      fontFamily: "Nunito",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 161),
                        child: Obx(
                          () => checkBoxController.isSelected.isTrue
                              ? buyDropDownButton(
                                  onTapButton: () {
                                    checkBoxController.isSelected(false);
                                  },
                                  textLabel: "Submit",
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: gray, width: 1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                  ),
                                  child: MaterialButton(
                                    height: 49,
                                    minWidth: 201,
                                    onPressed: () {
                                      checkBoxController.isSelected(true);
                                      Get.to(VerifyPinScreenInAccount());
                                    },
                                    color: white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                        25,
                                      ),
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                        color: gray,
                                        fontSize: 19,
                                        fontFamily: "NunitoSemiBold",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
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
