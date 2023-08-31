import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/data.dart';
import 'package:mymoney/utils/utils_text.dart';

class ExecutedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: executedListPageBuildDesign.length,
        itemBuilder: (context, index) => executedListDesign(
          con1Color: executedListPageBuildDesign[index]["con1Color"],
          con2Color: executedListPageBuildDesign[index]["con2Color"],
          bankName: executedListPageBuildDesign[index]["bankName"],
          orderPrice: executedListPageBuildDesign[index]["orderPrice"],
          con1Text: executedListPageBuildDesign[index]["con1Text"],
          con2Text: executedListPageBuildDesign[index]["con2Text"],
          ltp: executedListPageBuildDesign[index]["ltp"],
        ),
      ),
    );
  }
}

executedListDesign({
  Color? con1Color,
  String? con1Text,
  String? bankName,
  String? orderPrice,
  Color? con2Color,
  String? con2Text,
  String? ltp,
}) {
  return Container(
    margin: const EdgeInsets.only(
      left: 12,
      right: 12,
      bottom: 9,
      top: 9,
    ),
    padding: const EdgeInsets.only(
      left: 11,
      right: 6,
      bottom: 12,
      top: 9,
    ),
    height: 75,
    width: Get.width,
    decoration: BoxDecoration(
      color: pageBackGroundC,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xff26000000).withOpacity(0.1),
          spreadRadius: 0.1,
          blurRadius: 3,
          offset: Offset(0.5, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 46,
                  decoration: BoxDecoration(
                    color: con1Color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      con1Text!,
                      style: TextStyle(
                        fontSize: 8,
                        color: white,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "QTY:",
                        style: TextStyle(
                          fontSize: 8,
                          color: black.withOpacity(0.6),
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "1",
                        style: TextStyle(
                          fontSize: 8,
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
            Text(
              bankName!,
              style: TextStyle(
                fontSize: 12,
                color: black,
                fontFamily: "NunitoSemiBold",
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "NSE REG LIMIT",
              style: TextStyle(
                fontSize: 10,
                color: gray4,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Order Prise",
              style: TextStyle(
                fontSize: 8,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              orderPrice!,
              style: TextStyle(
                fontSize: 10,
                color: black,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "1mins ago",
                  style: TextStyle(
                    fontSize: 8,
                    color: black.withOpacity(0.6),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Container(
                  height: 18,
                  width: 52,
                  decoration: BoxDecoration(
                    color: con2Color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      con2Text!,
                      style: TextStyle(
                        fontSize: 8,
                        color: white,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "LTP",
                style: TextStyle(
                  fontSize: 8,
                  color: black.withOpacity(0.6),
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              ltp!,
              style: TextStyle(
                fontSize: 10,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
