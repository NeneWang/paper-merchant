import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/home/drawer_open_.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';

class WellDoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      /* appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: pageBackGroundC,
        elevation: 0,
        title: Center(
          child:
        ),
      ),*/
      body: Padding(
        padding: EdgeInsets.only(
            left: Get.width / 12.85,
            right: Get.width / 12.85,
            top: Get.height / 11.14 /*80*/),
        child: Column(
          children: [
            Text(
              "Well Done!",
              style: TextStyle(
                fontSize: 25,
                color: black2,
                fontFamily: "NunitoBold",
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                height: Get.height / 18.57 /*48*/,
                width: Get.width,
                child: Text(
                  "Your Phonw number is now being reviewed. You can expect it to finish in the next 24 hours",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: black2,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 6.19,
            ),
            SvgPicture.asset(
              wellDoneBenner,
              height: 227.81,
            ),
            SizedBox(
              height: Get.height / 4.79 /*186*/,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: MaterialButton(
                height: 46,
                minWidth: 200,
                onPressed: () {
                  Get.to(DrawerOpenScreen());
                },
                color: appColor,
                // elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(
                    25,
                  ),
                ),
                child: Text(
                  "Back to Profile",
                  style: TextStyle(
                    color: white,
                    fontSize: 19,
                    fontFamily: "NunitoSemiBold",
                    fontWeight: FontWeight.w600,
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
