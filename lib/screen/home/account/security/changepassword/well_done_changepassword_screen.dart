import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/home/account/security/security_screen.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';

class ChangePasswordWellDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: pageBackGroundC,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Well Done!",
              style: TextStyle(
                color: black2,
                fontSize: 25,
                fontFamily: "NunitoBold",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Your Password is save",
              style: TextStyle(
                color: black485068,
                fontSize: 15,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: Get.height / 5.94 /*150*/,
            ),
            SvgPicture.asset(changePasswordBenner),
            SizedBox(
              height: Get.height / 4.79 /*186*/,
            ),
            loginButton(
              onTapButton: () {
                Get.off(SecurityScreen());
              },
              textLabel: "Back to Profile",
            ),
          ],
        ),
      ),
    );
  }
}
