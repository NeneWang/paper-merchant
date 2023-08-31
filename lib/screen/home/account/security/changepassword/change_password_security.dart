import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/controller/checkbox_controller.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/textformfild.dart';
import 'well_done_changepassword_screen.dart';

// ignore: must_be_immutable
class ChangePasswordSecurity extends StatelessWidget {
  CheckBoxController checkBoxController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
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
          "Change Password",
          style: TextStyle(
            fontSize: 25,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 38),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              textFromFieldDesign3(
                label: "Current password",
                iconWidget1: Icon(
                  Icons.visibility_outlined,
                  color: gray4.withOpacity(0.3),
                ),
              ),
              textFromFieldDesign3(
                label: "New password",
                iconWidget1: Icon(
                  Icons.visibility_outlined,
                  color: gray4.withOpacity(0.3),
                ),
              ),
              textFromFieldDesign3(
                label: "Repeat password",
                iconWidget1: Icon(
                  Icons.visibility_outlined,
                  color: gray4.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Obx(
                  () => checkBoxController.isChange.isTrue
                      ? loginButton(
                          textLabel: "Change Password",
                          onTapButton: () {
                            Get.to(ChangePasswordWellDone());
                            checkBoxController.isChange(false);
                          },
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
                              checkBoxController.isChange(true);
                            },
                            color: white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(
                                25,
                              ),
                            ),
                            child: Text(
                              "Change Password",
                              style: TextStyle(
                                color: gray,
                                fontSize: 19,
                                fontFamily: "NunitoSemiBold",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                ), /*loginButton(
                  textLabel: "Change Password",
                  onTapButton: () {
                    Get.to(EnterOldPinScreen());
                  },
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}
