import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/home/watchlist/buy_sell_screen.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/data/utils.dart';

simpleStockListViewItem(
    /**
   * Worse design, less available configruations sofar
   */
    {String image = "assets/image/home/arrowDownRight.svg",
    String? title,
    String subTitle = "",
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
          // Image(
          //   image: AssetImage(image),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 20,
                    color: black,
                    fontFamily: "NunitoSemiBold",
                    fontWeight: FontWeight.w600,
                  ),
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
                lineBarsData: [getRandomLineChartData()],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  total!,
                  style: TextStyle(
                    fontSize: 20,
                    color: black,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
