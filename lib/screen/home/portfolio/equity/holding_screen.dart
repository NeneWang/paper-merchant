import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/data.dart';

class HoldingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: holdingListPageBuildDesign.length,
            itemBuilder: (context, index) => holdScreenListDesign(
              ltp: holdingListPageBuildDesign[index]["ltp"],
              bankName: holdingListPageBuildDesign[index]["bankName"],
              avgText: holdingListPageBuildDesign[index]["avgText"],
              conText: holdingListPageBuildDesign[index]["conText"],
              profileColor: holdingListPageBuildDesign[index]["profileColor"],
              profileText1: holdingListPageBuildDesign[index]["profileText1"],
              profileText2: holdingListPageBuildDesign[index]["profileText2"],
              qty: holdingListPageBuildDesign[index]["qty"],
            ),
          ),
        ),
        Container(
          height: 90,
          width: Get.width,
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: Color(0xff40000000),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 19, right: 19, bottom: 10, top: 10),
                height: 37,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Invested",
                          style: TextStyle(
                            fontSize: 12,
                            color: black2.withOpacity(0.6),
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Current",
                          style: TextStyle(
                            fontSize: 12,
                            color: black2.withOpacity(0.6),
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "30200.00",
                          style: TextStyle(
                            fontSize: 12,
                            color: black2,
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "+30700.05",
                          style: TextStyle(
                            fontSize: 12,
                            color: green219653,
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 19,
                  right: 19,
                ),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: gray4.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 19, right: 19, top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today P&L",
                      style: TextStyle(
                        fontSize: 12,
                        color: black2.withOpacity(0.6),
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                        child: Row(
                      children: [
                        Text(
                          "+217.95 ",
                          style: TextStyle(
                            fontSize: 12,
                            color: green219653,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          " +2.20%",
                          style: TextStyle(
                            fontSize: 9,
                            color: green219653,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

holdScreenListDesign({
  String? qty,
  String? bankName,
  String? avgText,
  String? profileText1,
  String? profileText2,
  Color? profileColor,
  String? conText,
  String? ltp,
}) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 12),
    margin: EdgeInsets.only(left: 12, right: 12, top: 20),
    height: 75,
    width: Get.width,
    decoration: BoxDecoration(
      color: Color(0xffF4F7FB),
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
                    text: qty,
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
              "Avg. $avgText",
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
              "Profit",
              style: TextStyle(
                fontSize: 10,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: profileText1,
                    style: TextStyle(
                      fontSize: 11,
                      color: profileColor,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "(",
                    style: TextStyle(
                      fontSize: 11,
                      color: black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: profileText2,
                    style: TextStyle(
                      fontSize: 11,
                      color: profileColor,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ")",
                    style: TextStyle(
                      fontSize: 11,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  "Invested",
                  style: TextStyle(
                    fontSize: 8,
                    color: black.withOpacity(0.6),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 18,
                  width: 52,
                  decoration: BoxDecoration(
                    color: green219653,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      conText!,
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
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "LTP",
                style: TextStyle(
                  fontSize: 10,
                  color: black.withOpacity(0.6),
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              ltp!,
              style: TextStyle(
                fontSize: 11,
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
