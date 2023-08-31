import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';

class FundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: pageBackGroundC,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 14.85),
              child: Column(
                children: [
                  Text(
                    "Funds",
                    style: TextStyle(
                      fontSize: 26,
                      color: black2,
                      fontFamily: "NunitoBold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: Get.width,
              height: Get.height / 1.33,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.56),
                  topRight: Radius.circular(22.56),
                ),
                /*   image: DecorationImage(
                  image: AssetImage(bg1),
                  fit: BoxFit.cover,
                ),*/
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: Get.height / 74.285,
                ),
                child: Column(
                  children: [
                    Text(
                      "Cash + Assets",
                      style: TextStyle(
                        fontSize: 17,
                        color: gray,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "2,265.35",
                      style: TextStyle(
                        fontSize: 21,
                        color: appColor,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: Get.height / 97.42,
                        left: Get.width / 25.71,
                        right: Get.width / 41.14,
                      ),
                      child: Divider(
                        color: gray,
                        thickness: 1,
                      ),
                    ),
                    design1(text1: "Cash", text2: "2,4389"),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.28, left: 16, top: 10),
                      child: Divider(
                        color: gray,
                        thickness: 1,
                      ),
                    ),
                    design1(text1: "Assets", text2: "0.00"),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          resetFundButton(
                              onTapButton: () {}, textLabel: "Reset Funds"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

design1({String? text1, String? text2}) {
  return Padding(
    padding: EdgeInsets.only(
      left: Get.width / 17.19,
      right: Get.width / 22.63,
      top: Get.height / 89.14,
    ),
    child: Container(
      height: Get.height / 14.91,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1!,
            style: TextStyle(
              fontSize: 16,
              color: black2.withOpacity(0.6),
              fontFamily: "NunitoSemiBold",
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text2!,
            style: TextStyle(
              fontSize: 18,
              color: black2,
              fontFamily: "NunitoSemiBold",
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    ),
  );
}
