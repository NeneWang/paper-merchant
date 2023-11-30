import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:papermarket/controller/conteiner_color_change_keypade.dart';
import 'package:papermarket/controller/tabcontroller_screen.dart';

import 'package:papermarket/screen/home/watchlist/toggle_design_screen.dart';
import 'package:papermarket/utils/buttons_widget.dart';
import 'package:papermarket/utils/color.dart';

import 'package:papermarket/data/database.dart';

import 'package:papermarket/components/QuantityRow.dart';
import 'package:papermarket/components/NamesWithPricing.dart';

final applicationController myTabController = Get.put(applicationController());
// ColorChangeController colorChangeController = Get.put(
//   ColorChangeController(),
// );

// Function to reload the page
void reloadPage(BuildContext context) {
  Navigator.of(context).popAndPushNamed('/your_page_route_name');
}

class BuySellScreen extends StatefulWidget {
  final String ticker;
  final String price;

  // should accept  Map<String, String>? stockData
  final Map<String, dynamic>? stockData;

  const BuySellScreen(
      {super.key, required this.ticker, required this.price, this.stockData});

  @override
  State<BuySellScreen> createState() => _BuySellScreenState();
}

class _BuySellScreenState extends State<BuySellScreen> {
  final db = Database();

  final blackBoldStyle = const TextStyle(
      fontSize: 18,
      color: black,
      fontFamily: "Nunito",
      fontWeight: FontWeight.w400);

  final greenBoldStyle = const TextStyle(
      fontSize: 18,
      color: green219653,
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
    // final GlobalKey<_MyPageState> _key = GlobalKey();
    String sample = "";
    void reloadPage() {
      print("Page reloaded");
      setState(() {
        sample = "Hello";
      });
    }

    String userCash = "0";
    bool moreCashThanCost(double currentPrice) {
      double totalCost = currentPrice;
      if (totalCost > double.parse(userCash)) {
        return false;
      } else {
        return true;
      }
    }

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
            widget.ticker,
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
                        Text(widget.price, style: blackBoldStyle)
                      ],
                    )
                  ],
                ),
              ),
            ),
            widget.stockData != null &&
                    widget.stockData?["type"] != null &&
                    widget.stockData?["type"] == "CS"
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 21, left: 13, right: 18),
                    child: SizedBox(
                      width: Get.width,
                      // height: 156,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.stockData?["description"][0]
                                        .toString() ??
                                    "Description",
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Market Cap"),
                                    Text(
                                        widget.stockData?["market_cap"]
                                                .toStringAsFixed(2) ??
                                            "Market Cap",
                                        style: blackBoldStyle),
                                    SizedBox(height: 5),
                                    const Text('Volume'),
                                    Text(
                                        widget.stockData?["Volume"]
                                                .toStringAsFixed(2) ??
                                            "Volume",
                                        style: blackBoldStyle),
                                    SizedBox(height: 5),
                                    const Text(
                                        'Standard Industrial Classification:'),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        widget.stockData?["sic_description"]
                                                .toString() ??
                                            "sic_description",
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('total_employees'),
                                      Text(
                                          widget.stockData?["total_employees"]
                                                  .toStringAsFixed(2) ??
                                              "total_employees",
                                          style: blackBoldStyle),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("city", style: blackBoldStyle),
                                      Text(
                                        widget.stockData?["city"].toString() ??
                                            "city",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("state", style: blackBoldStyle),
                                      Text(
                                          widget.stockData?["state"]
                                                  .toString() ??
                                              "state",
                                          style: blackBoldStyle),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            Divider(
              thickness: 3,
              color: grayF2F2F2,
            ),
            FutureBuilder(
                future: db.getDetailsShare(widget.ticker, widget.price),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    userCash = snapshot.data!["user_cash"];
                    print("usercash db.getDetailsShare $userCash");
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 21, left: 13, right: 18),
                      child: snapshot.data?["shares_owned"] != null &&
                              snapshot.data?["shares_owned"] != "0" &&
                              snapshot.data?["shares_owned"] != ""
                          ? Container(
                              width: Get.width,
                              height: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Average Price bought at"),
                                      Text(sample),
                                      Text(
                                        snapshot.data![
                                            "shares_owned_average_price"],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: "NunitoBold",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(userCash == ""
                                          ? ""
                                          : "Cash Available"),
                                      Text(userCash)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                text: snapshot.data![
                                                    "shares_owned_profit"],
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
                            )
                          : Container(),
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("Loading user data..."),
                          SizedBox(
                            height: 22,
                          ),
                          Divider(
                            thickness: 3,
                            color: grayF2F2F2,
                          ),
                        ],
                      ),
                    );
                  }
                }),
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
                          price: widget.price,
                          symbol: widget.ticker, purchaseMethod: (String symbol,
                              {required int count, required double price}) {
                        db.purchaseStock(symbol, count: count, price: price);

                        print('userCash: $userCash');
                        reloadPage();
                      }, userCash: userCash);
                    },
                  ),
                  sellButton(
                    textLabel: "SELL",
                    onTapButton: () {
                      sellDialog(context,
                          price: widget.price,
                          symbol: widget.ticker, sellMethod: (String symbol,
                              {required int count, required double price}) {
                        db.sellStock(symbol, count: count, price: price);
                        reloadPage();
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 3,
              color: grayF2F2F2,
            ),
            // History
            Padding(
              padding: const EdgeInsets.only(top: 21, left: 13, right: 18),
              child: SizedBox(
                // width: Get.width,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text("History",
                        style: TextStyle(
                          fontSize: 28,
                          color: black2,
                          fontFamily: "NunitoBold",
                          fontWeight: FontWeight.w700,
                        )),
                    Row(children: [
                      Text('AMZN SELL',
                          style: TextStyle(
                            fontSize: 18,
                          ))
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[Text('2022-01-01'), Text('+ 40.23')],
                    ),
                    Divider(),
                  ],
                ),
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
                // dismiss
                Get.back();
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
                // dismiss
                Get.back();
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

buyMenuData({symbol, price, color1, quantityController, userCash = ""}) {
  print("userCash: $userCash");
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
                userCash == "" ? "Cash Available" : "",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                userCash == "" ? "" : "\$${userCash}",
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
