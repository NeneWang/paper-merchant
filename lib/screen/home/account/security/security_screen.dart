import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/home/drawer_open_.dart';
import 'changepin/enter_old.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';

import '../account_screen.dart';
import 'changepassword/change_password_security.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.to(DrawerOpenScreen());
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
          "Security",
          style: TextStyle(
            fontSize: 25,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: Get.height / 10.74),
          child: Column(
            children: [
              SvgPicture.asset(
                securityBenner,
                height: Get.height / 3.84,
              ),
              Container(
                height: Get.height / 1.83,
                width: Get.width,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(ChangePasswordSecurity());
                        },
                        child: design1Profile(
                          labelText: "Change Password",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(EnterOldPinScreen());
                        },
                        child: design1Profile(
                          labelText: "Change PIN",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
