import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/screen/home/watchlist/simple_buy_sell_screen.dart';

import 'package:paper_merchant/utils/color.dart';

simpleStockListViewItem(
    /**
      * Basic design with a random chart, and price.
    */
    {
  String? title,
  String? total,
  BuildContext? context,
  String? imageUrl,
  colorName = "black",
  Map<String, dynamic>? stockData,
}) {
  return InkWell(
    onTap: () {
      Get.to(BuySellScreen(ticker: title, price: total, stockData: stockData));
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
          imageUrl != null && imageUrl.isNotEmpty && imageUrl != ""
              ? Image.network(
                  imageUrl,
                )
              : Container(),
          // Image.network(
          //   "https://api.polygon.io/v1/reference/company-branding/d3d3LmpwbW9yZ2FuY2hhc2UuY29t/images/2023-05-01_icon.jpeg?apiKey=JzpLmiKOusmtMSoeIQxAjhdeU8aPS5QO",
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  title!,
                  style: const TextStyle(
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  total!,
                  style: const TextStyle(
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
