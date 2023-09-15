import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mymoney/controller/conteiner_color_change_keypade.dart';
import 'package:mymoney/controller/tabcontroller_screen.dart';

import 'package:mymoney/screen/home/watchlist/toggle_design_screen.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';

import 'package:mymoney/data/database.dart';

import 'package:mymoney/components/QuantityRow.dart';
import 'package:mymoney/components/NamesWithPricing.dart';

final MyTabController myTabController = Get.put(MyTabController());
ColorChangeController colorChangeController = Get.put(
  ColorChangeController(),
);

class BuySellScreen extends StatelessWidget {
  final String ticker;
  final String price;

  BuySellScreen({required this.ticker, required this.price});
  final db = Database();

  final blackBoldStyle = const TextStyle(
      fontSize: 18,
      color: black,
      fontFamily: "Nunito",
      fontWeight: FontWeight.w400);

  final smallLetterStyle = const TextStyle(
    fontSize: 18,
    fontFamily: "NunitoBold",
    fontWeight: FontWeight.w700,
  );

  final largeText = const TextStyle(
    fontSize: 20,
    color: black2,
    fontFamily: "NunitoBold",
    fontWeight: FontWeight.w700,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: pageBackGroundC,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: black1,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Text(
            ticker,
            style: TextStyle(
              fontSize: 20,
              color: black2,
              fontFamily: "NunitoBold",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 21, left: 13, right: 18),
              child: Container(
                width: Get.width,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ToggleScreen(green219653),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21, left: 13, right: 18),
              child: SizedBox(
                width: Get.width,
                height: 56,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Current Price"),
                        Text(price, style: blackBoldStyle)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 3,
              color: grayF2F2F2,
            ),
            FutureBuilder(
                future: db.getDetailsShare(ticker, price),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 21, left: 13, right: 18),
                      child: Container(
                        width: Get.width,
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Average Price bought at"),
                                Text(
                                  snapshot.data!["shares_owned_average_price"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "NunitoBold",
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("Shares Owned"),
                                    Text(
                                      snapshot.data!["shares_owned"],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: black,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  "Total Profit",
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: snapshot
                                              .data!["shares_owned_profit"],
                                          style: blackBoldStyle),
                                      TextSpan(
                                        text: " (",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: black,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: snapshot.data![
                                            "shares_owned_profit_percent"],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: green219653,
                                          fontFamily: "Nunito",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ")",
                                        style: TextStyle(
                                          fontSize: 18,
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
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("Loading user data..."),
                        ],
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 22,
            ),
            Divider(
              thickness: 3,
              color: grayF2F2F2,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 33, right: 33, bottom: 16),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buyButton(
                    textLabel: "BUY",
                    onTapButton: () {
                      buyDialog(context,
                          price: price,
                          symbol: ticker,
                          purchaseMethod: db.purchaseStock,
                          userCash: db.userData["cash"].toStringAsFixed(2));
                    },
                  ),
                  sellButton(
                    textLabel: "SELL",
                    onTapButton: () {
                      sellDialog(context,
                          price: price,
                          symbol: ticker,
                          sellMethod: db.sellStock);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buyDialog(context,
    {String symbol = "", String price = "0", purchaseMethod, userCash = "0"}) {
  final TextEditingController _totalCostController =
      TextEditingController(text: '1');

  return Get.defaultDialog(
    // barrierDismissible: true,
    barrierDismissible: true,
    contentPadding: EdgeInsets.all(0),
    radius: 31,
    title: "",
    titlePadding: EdgeInsets.all(0),
    content: Container(
      width: Get.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(CupertinoIcons.clear),
              ),
            ),
          ),
          buyMenuData(
              symbol: symbol,
              price: price,
              color1: appColor2F80ED,
              userCash: userCash),
          Divider(
            thickness: 3,
            color: grayF2F2F2,
          ),
          priceQuantity(
              color2: appColor,
              price: price,
              totalcostController: _totalCostController),
          Padding(
            padding: EdgeInsets.only(top: 39, bottom: 16),
            child: buyDropDownButton(
              textLabel: "BUY",
              onTapButton: () {
                print("_totalCostController.text");
                // print(_totalCostController.text);
                String totalCostString = _totalCostController.text;

                // Check if the input string is a valid integer
                double totalCost = double.parse(totalCostString);
                int count = (totalCost / double.parse(price)).round();

                purchaseMethod(symbol,
                    count: count, price: double.parse(price));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

sellDialog(context, {String symbol = "", String price = "0", sellMethod}) {
  final TextEditingController _totalProfitController =
      TextEditingController(text: '1');
  return Get.defaultDialog(
    // barrierDismissible: true,
    barrierDismissible: true,
    contentPadding: const EdgeInsets.all(0),
    radius: 31,
    title: "",
    titlePadding: const EdgeInsets.all(0),
    content: Container(
      width: Get.width,
      child: Column(
        children: [
          priceQuantity(
              color2: redEB5757,
              price: price,
              totalcostController: _totalProfitController),
          Padding(
            padding: EdgeInsets.only(top: 39, bottom: 16),
            child: sellDropDownButton(
              onTapButton: () {
                String totalCostString = _totalProfitController.text;

                // Check if the input string is a valid integer
                double totalCost = double.parse(totalCostString);
                int count = (totalCost / double.parse(price)).round();

                sellMethod(symbol, count: count, price: double.parse(price));
              },
              textLabel: "SELL",
            ),
          ),
        ],
      ),
    ),
  );
}

design1({price, symbol, color1}) {
  return NamesWithPricing(
    price: price,
    symbol: symbol,
    color1: color1,
  );
}

buyMenuData({symbol, price, color1, quantityController, userCash}) {
  return Padding(
    padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
    child: Container(
      width: Get.width,
      height: /*Get.height/ 15.91*/ 76,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                symbol,
                style: TextStyle(
                  fontSize: 18,
                  color: black2,
                  fontFamily: "NunitoBold",
                  fontWeight: FontWeight.w700,
                ),
              ),
              ToggleScreenBuy(color1),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${price}",
                style: TextStyle(
                  fontSize: 18,
                  color: color1,
                  fontFamily: "NunitoBold",
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Cash Available",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "\$${userCash}",
                style: TextStyle(
                  fontSize: 18,
                  color: black2,
                  fontFamily: "NunitoBold",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

design1Sell({color1}) {
  return Padding(
    padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
    child: Container(
      width: Get.width,
      height: /*Get.height/ 15.91*/ 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AXISBANK",
                style: TextStyle(
                  fontSize: 18,
                  color: black2,
                  fontFamily: "NunitoBold",
                  fontWeight: FontWeight.w700,
                ),
              ),
              ToggleScreenSell(color1),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹2126.20",
                style: TextStyle(
                  fontSize: 18,
                  color: color1,
                  fontFamily: "NunitoBold",
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

priceQuantity({color2, price = "0.00", totalcostController}) {
  double priceValue = double.parse(price);

  return Padding(
    padding: EdgeInsets.only(
        left: Get.width / 24.20 /* 17*/,
        right: Get.width / 24.20 /*17*/,
        top: 17),
    child: Container(
      height: 60,
      child: QuantitiyRow(
          singularPrice: priceValue, totalcostController: totalcostController),
    ),
  );
}

design3({color2}) {
  return Padding(
    padding: EdgeInsets.only(
        left: Get.width / 24.20 /*17*/,
        right: Get.width / 24.20 /*17*/,
        top: 17,
        bottom: 20),
    child: Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mode",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 31,
                width: Get.width / 4.37 /*94*/,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: pageBackGroundC,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Intraday",
                    style: TextStyle(
                      fontSize: 13,
                      color: appColor,
                      fontFamily: "NunitoSemiBold",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                /* child: TextField(
                  textAlign: TextAlign.start,
                  cursorColor: black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),*/
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 31,
                width: Get.width / 4.37 /*94*/,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Color(0xff66000000),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 13,
                      color: gray4,
                      fontFamily: "NunitoSemiBold",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Validity",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 31,
                width: Get.width / 4.37 /*94*/,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                      () => DropdownButton<String>(
                        // menuMaxHeight: 40,
                        // itemHeight: 20,
                        isDense: true,
                        value: myTabController.selectedValue1.value,
                        focusColor: appColor,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontFamily: "NunitoBold",
                          fontWeight: FontWeight.w700,
                        ),
                        autofocus: true,
                        elevation: 0,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: white,
                        ),
                        // isDense: true,
                        items: myTabController.dropList1.map((e) {
                          return DropdownMenuItem(
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 13,
                                color: black,
                                fontFamily: "NunitoBold",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (val) {
                          myTabController.setSelected1(val!);
                        },
                      ),
                    ),
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

design3Sell({color2}) {
  return Padding(
    padding: EdgeInsets.only(
        left: Get.width / 24.20 /*17*/,
        right: Get.width / 24.20 /*17*/,
        top: 17,
        bottom: 20),
    child: Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mode",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 31,
                width: Get.width / 4.37 /*94*/,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Color(0xff66000000),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Intraday",
                    style: TextStyle(
                      fontSize: 13,
                      color: gray4,
                      fontFamily: "NunitoSemiBold",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 31,
                width: Get.width / 4.37 /*94*/,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Color(0xff66000000),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Delivery",
                    style: TextStyle(
                      fontSize: 13,
                      color: gray4,
                      fontFamily: "NunitoSemiBold",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Validity",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 31,
                width: Get.width / 4.37 /*94*/,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: Obx(
                      () => DropdownButton<String>(
                        // menuMaxHeight: 40,
                        // itemHeight: 20,
                        isDense: true,
                        value: myTabController.selectedValue1.value,
                        focusColor: appColor,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontFamily: "NunitoBold",
                          fontWeight: FontWeight.w700,
                        ),
                        autofocus: true,
                        elevation: 0,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: white,
                        ),
                        // isDense: true,
                        items: myTabController.dropList1.map((e) {
                          return DropdownMenuItem(
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 13,
                                color: black,
                                fontFamily: "NunitoBold",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (val) {
                          myTabController.setSelected1(val!);
                        },
                      ),
                    ),
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
