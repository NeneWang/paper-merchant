import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/welcome/welcome_screen.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/data.dart';
import 'package:mymoney/utils/imagenames.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: white,
      child: Padding(
        padding:
            EdgeInsets.only(top: Get.height / 9.48, left: Get.width / 10.28),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 35,
              backgroundImage: AssetImage(personImage),
              backgroundColor: white,
            ),
            SizedBox(
              height: Get.height / 59.42,
            ),
            Container(
              width: Get.width / 4.57,
              height: Get.height / 12.73,
              child: Text(
                "Mattie Hardwick",
                style: TextStyle(
                  fontSize: 19,
                  color: black0D1F3C,
                  fontFamily: "TitilliumWebSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            /* SizedBox(
              height: 10
            ),*/
            Padding(
              padding: EdgeInsets.only(left: Get.width / 3.29),
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: drawerList.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      print("d vev eve");
                      if (index == 7) {
                        Get.defaultDialog(
                          barrierDismissible: true,
                          title: "",
                          contentPadding: EdgeInsets.all(0),
                          titlePadding: EdgeInsets.all(0),
                          content: Container(
                            width: Get.width,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  logOut,
                                  color: redEB5757,
                                  height: 43,
                                ),
                                SizedBox(
                                  height: 23,
                                ),
                                Text(
                                  "Are you sure you want to Logout.?",
                                  style: TextStyle(
                                    color: black,
                                    fontFamily: "NunitoSemiBold",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 23,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      height: 39,
                                      minWidth: 118,
                                      onPressed: () {
                                        Get.off(WelcomeScreen());
                                      },
                                      color: white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        side:
                                            BorderSide(color: black2, width: 1),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                          12,
                                        ),
                                      ),
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontFamily: "NunitoBold",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 22,
                                    ),
                                    MaterialButton(
                                      height: 39,
                                      minWidth: 118,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      color: appColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                          12,
                                        ),
                                      ),
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 18,
                                          fontFamily: "NunitoBold",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    leading: SvgPicture.asset(
                      drawerList[index]["img"],
                      height: Get.height / 44.571,
                    ),
                    minLeadingWidth: Get.width / 20.57,
                    title: Text(
                      drawerList[index]["title"],
                      style: TextStyle(
                        fontSize: Get.width / 21.65,
                        color: black0D1F3C,
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
    );
  }
}
