import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paper_merchant/controller/tabcontroller_screen.dart';

import 'package:paper_merchant/screen/home/watchlist/toggle_design_screen.dart';
import 'package:paper_merchant/utils/buttons_widget.dart';
import 'package:paper_merchant/utils/color.dart';

import 'package:paper_merchant/data/database.dart';

import 'package:paper_merchant/components/QuantityRow.dart';
import 'package:paper_merchant/components/NamesWithPricing.dart';
import 'package:url_launcher/url_launcher.dart';

final applicationController myTabController = Get.put(applicationController());
// ColorChangeController colorChangeController = Get.put(
//   ColorChangeController(),
// );

// Function to reload the page
void reloadPage(BuildContext context) {
  Navigator.of(context).popAndPushNamed('/your_page_route_name');
}

// ignore: non_constant_identifier_names
String YAHOO_PRICING = 'https://finance.yahoo.com/quote/';

// ignore: non_constant_identifier_names
Future<void> launch_latest_competition_url(symbol) async {
  String shareYahooStock = YAHOO_PRICING + symbol;
  Uri uri = Uri.parse(shareYahooStock);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $shareYahooStock');
  }
}

Future<void> launch_transaction_execution_preview(player_id) async {
  String baseUrl =
      'https://crvmb5tnnr.us-east-1.awsapprunner.com/api/preview_execution_report/';
  String url = baseUrl + player_id;
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
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

  bool isBookmarked = false;

  // At init state, check if the stock is bookmarked
  @override
  void initState() {
    super.initState();
    db.loadData();
    isBookmarked = db.isBookmarked(widget.ticker);
  }

  @override
  Widget build(BuildContext context) {
    String userCash = "0";

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: pageBackGroundC,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
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
            style: const TextStyle(
              fontSize: 20,
              color: black2,
              fontFamily: "NunitoBold",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked
                  ? CupertinoIcons.bookmark_fill
                  : CupertinoIcons.bookmark,
              color: black1,
            ),
            onPressed: () {
              // Add your bookmark logic here
              final bookmarkRes = db.toggleBookmark(widget.ticker);
              print("Bookmark result: $bookmarkRes");
              setState(() {
                isBookmarked = bookmarkRes;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 21, left: 13, right: 18),
              child: SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("15 Mins Delayed Price"),
                        Row(
                          children: [
                            Text(widget.price, style: blackBoldStyle),
                            TextButton(
                              onPressed: () {
                                launch_latest_competition_url(widget.ticker);
                              },
                              child: Text(
                                "Check the real current price here.",
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: Get.width * 0.8,
                          child: const Text(
                              "Transaction prices will be updated to reflect the price (from the real stock market) using the moment bought by the end of the day."),
                        ),
                        TextButton(
                            onPressed: () {
                              launch_transaction_execution_preview(
                                  db.userData['player_id']);
                            },
                            child:
                                Text("Preview Transaction Execution Report")),
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
                        width: Get.width * 0.4,
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
                            const Height5(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Market Cap"),
                                      Text(
                                          widget.stockData?["market_cap"]
                                                  .toStringAsFixed(2) ??
                                              "Market Cap",
                                          style: blackBoldStyle),
                                      const Height5(),
                                      const Text('Volume'),
                                      Text(
                                          widget.stockData?["Volume"]
                                                  .toStringAsFixed(2) ??
                                              "Volume",
                                          style: blackBoldStyle),
                                      const Height5(),
                                      const Text(
                                          'Standard Industrial Classification:'),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Text(
                                          widget.stockData?["sic_description"]
                                                  .toString() ??
                                              "sic_description",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('total_employees'),
                                      Text(
                                          widget.stockData?["total_employees"]
                                                  .toStringAsFixed(2) ??
                                              "total_employees",
                                          style: blackBoldStyle),
                                      const Height5(),
                                      Text("city", style: blackBoldStyle),
                                      Text(
                                        widget.stockData?["city"].toString() ??
                                            "city",
                                      ),
                                      const Height5(),
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
            FutureBuilder(
                future: db.getDetailsShare(widget.ticker, widget.price),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    userCash = snapshot.data!["user_cash"];
                    return Padding(
                      padding: const EdgeInsets.only(left: 13, right: 18),
                      child: snapshot.data?["shares_owned"] != null &&
                              snapshot.data?["shares_owned"] != "0" &&
                              snapshot.data?["shares_owned"] != ""
                          ? SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Divider(
                                        thickness: 3,
                                        color: grayF2F2F2,
                                      ),
                                      const Text("Average Price bought at"),
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
                                            const TextSpan(
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
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: green219653,
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const TextSpan(
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
                    return const Center(
                      child: Column(),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(
                  top: 13, left: 33, right: 33, bottom: 16),
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
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 3,
              color: grayF2F2F2,
            ),
            // History
            Padding(
              padding: const EdgeInsets.only(top: 11, left: 13, right: 18),
              child: SizedBox(
                // width: Get.width,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    FutureBuilder<List>(
                      future: db.getTickerTransactions(widget.ticker),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final item = snapshot.data![index];
                              // return const Text("Hello");
                              return historyListViewItem(
                                symbol: item["symbol"],
                                price: item["price"],
                                count: item["count"],
                                type: item["transaction_type"],
                                date: item["created_time"],
                              );
                            },
                          );
                        } else {
                          return const Center();
                        }
                      },
                    ),
                    const Divider(),
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

class Height5 extends StatelessWidget {
  const Height5({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 5,
    );
  }
}

historyListViewItem({symbol, price, count, type, date}) {
  // Sign is positive if is sell, negative if is buy
  String sign = "";
  if (type.toUpperCase() == "SELL") {
    sign = "+";
  } else {
    if (price > 0) {
      sign = "-";
    }
  }
  // String operation = type.toUpperCase() == "SELL" ? "SELL" : "BUY ";
  String onlyDate = "UTC: ${date.toString().split(".")[0]}";
  return Row(children: [
    Text(' $symbol ${type.toUpperCase()}',
        style: const TextStyle(
          fontSize: 18,
        )),
    const Spacer(),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text(onlyDate), Text('$sign \$$price')],
    )
  ]);
}

buyDialog(context,
    {String symbol = "", String price = "0", purchaseMethod, userCash = "0"}) {
  final TextEditingController totalCostController =
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
                icon: const Icon(CupertinoIcons.clear),
              ),
            ),
          ),
          buyMenuData(
              symbol: symbol,
              price: price,
              color1: appColor2F80ED,
              userCash: userCash),
          const Divider(
            thickness: 3,
            color: grayF2F2F2,
          ),
          priceQuantity(
              color2: appColor,
              price: price,
              totalcostController: totalCostController),
          Padding(
            padding: const EdgeInsets.only(top: 39, bottom: 16),
            child: buyDropDownButton(
              textLabel: "BUY",
              onTapButton: () {
                print("_totalCostController.text");
                // print(_totalCostController.text);
                String totalCostString = totalCostController.text;

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
