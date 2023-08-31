import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';

class PendingOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(benner1oderscreen,height: Get.height/4.22,),
        SizedBox(
          height:Get.height/178.28,
        ),
        Text(
          "You Have Not Placed Any Orders!",
          style: TextStyle(
            fontSize: 15,
            color: black2,
            fontFamily: "NunitoSemiBold",
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Go to Watchlist",
          style: TextStyle(
            fontSize: 15,
            color: appColor,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
