import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/screen/home/watchlist/buy_sell_screen.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/data/utils.dart';

listViewItemDesignMostStock(
    {String? image,
    String? title,
    String? subTitle,
    String? total,
    String? stock1,
    String? stock2,
    BuildContext? context,
    colorName}) {
  return InkWell(
    onTap: () {
      Get.to(BuySellScreen());
    },
    child: Container(
      margin: EdgeInsets.only(
        left: Get.width / 34.28,
        right: Get.width / 34.28,
        bottom: Get.height / 99.04,
      ),
      padding: EdgeInsets.only(
        left: Get.width / 68.57,
        right: Get.width / 37.40,
        top: Get.height / 127.34,
        bottom: Get.height / 99.04,
      ),
      height: 60,
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
          // SvgPicture.asset(image!),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                  fontSize: 15,
                  color: black,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subTitle!,
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            width: 84,
            height: 29,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(
                  show: false,
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2.6, 2),
                      FlSpot(4.9, 5),
                      FlSpot(6.8, 2.5),
                      FlSpot(8, 6),
                      FlSpot(9.5, 7),
                      FlSpot(11, 7),
                    ],
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: [
                        const Color(0xff73BE8C).withOpacity(0.4),
                        const Color(0xf73BE8C),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                total!,
                style: TextStyle(
                  fontSize: 15,
                  color: colorName,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: stock1,
                      style: TextStyle(
                        fontSize: 15,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "(",
                      style: TextStyle(
                        fontSize: 15,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: stock2,
                      style: TextStyle(
                        fontSize: 15,
                        color: colorName,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ")",
                      style: TextStyle(
                        fontSize: 15,
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
        ],
      ),
    ),
  );
}
