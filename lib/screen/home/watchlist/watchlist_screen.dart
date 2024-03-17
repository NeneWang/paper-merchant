import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paper_merchant/controller/tabcontroller_screen.dart';
import 'package:paper_merchant/screen/home/watchlist/all_stocks_screen.dart';
import 'package:paper_merchant/screen/home/watchlist/home_screen.dart';

import 'package:paper_merchant/components/simpleListItemDesign.dart';

import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/data/database.dart';
import 'package:paper_merchant/data/utils.dart';
import '../notification_screen.dart';
import 'package:paper_merchant/components/loading_placeholder.dart';
// Get Reload icon

// ignore: use_key_in_widget_constructors
class TradeScreen extends StatefulWidget {
  final applicationController myTabController =
      Get.put(applicationController());
  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  final applicationController myTabController =
      Get.put(applicationController());

  final Database db = Database();
  List stockList = [];
  List bookmarkedList = [];
  bool loaded = false;
  late Timer _timer;

  reloadScreen({onlyDB = false, onlySync = false}) async {
    if (!onlySync) {
      db.loadData();
    }

    if (!onlyDB) {
      await db.syncData();
      setState(() {
        loaded = true;
      });
    }

    setState(() {
      stockList = convertToListingFormat(db.userStockPrices);
    });

    setState(() {
      bookmarkedList = convertToListingFormat(db.userBookmarkPrices);
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      reloadScreen();
    });
    reloadScreen(); // Initial data load
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userHero = [
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(
              right: Get.width / 20.57,
              top: Get.height / 178.28,
              bottom: Get.height / 178.28),
          child: InkWell(
            onTap: () {
              reloadScreen();
            },
            child: const Icon(
              CupertinoIcons.refresh,
              size: 24, // Adjust the size as needed
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(
              right: Get.width / 20.57, top: Get.height / 178.28),
          child: InkWell(
            onTap: () {
              Get.to(NotificationScreen());
            },
            child: const Icon(
              CupertinoIcons.bell,
              size: 24, // Adjust the size as needed
            ),
          ),
        ),
      ),
      SizedBox(
          height: Get.height / 5,
          child: tabAssetsView(
              db.userData["cash"]?.toStringAsFixed(2) ?? "0",
              db.userData["papel_asset_worth"]?.toStringAsFixed(2) ?? "0",
              db.userData["competition_name"] ?? "")),
    ];

    // ignore: non_constant_identifier_names
    var StocksData = [
      Container(
        height: Get.height * 1.2 /*(Get.height > 891) ? Get.height : 275*/,
        width: Get.width,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: Get.width / 31.64,
                  top: Get.height / 89.14,
                  left: Get.width / 31.64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Stocks",
                    style: TextStyle(
                      fontSize: 18,
                      color: black0D1F3C,
                      fontFamily: "NunitoBold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllStockScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 15,
                        color: appColor,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stockList.length,
              itemBuilder: (context, index) => simpleStockListViewItem(
                context: context,
                title: stockList[index]["title"],
                total: stockList[index]["totalRs"],
                imageUrl: stockList[index]["imageUrl"],
                stockData: db.userStockPrices[stockList[index]["title"]],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 14),
              child: Divider(
                height: 2,
                thickness: 2,
                color: grayF2F2F2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: Get.width / 31.64, left: Get.width / 31.64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Bookmark",
                    style: TextStyle(
                      fontSize: 18,
                      color: black0D1F3C,
                      fontFamily: "NunitoBold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      /*  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllStockScreen(),
                                    ),
                                  );*/
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 15,
                        color: appColor,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 1),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookmarkedList.length,
              itemBuilder: (context, index) => simpleStockListViewItem(
                context: context,
                title: bookmarkedList[index]["title"],
                total: bookmarkedList[index]["totalRs"],
                imageUrl: bookmarkedList[index]["imageUrl"],
                stockData:
                    db.userBookmarkPrices[bookmarkedList[index]["title"]],
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          reloadScreen(onlyDB: true);
          reloadScreen(onlySync: true);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBarDesign(),
              Column(
                children: userHero,
              ),
              if (!loaded)
                LoadingPlaceholder(
                  waitingMessage: "Loading your data...",
                ),
              if (loaded)
                Column(
                  children: StocksData,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

tabAssetsView(String totalCash, String totalAssets, String comeptitionName) {
  String totalWorth =
      (double.parse(totalCash) + double.parse(totalAssets)).toStringAsFixed(2);
  const greenTextStyle = TextStyle(
    fontSize: 15,
    color: green219653,
    fontFamily: "Nunito",
    fontWeight: FontWeight.w400,
  );
  const blackTextStyle = TextStyle(
    fontSize: 15,
    color: black,
    fontFamily: "Nunito",
    fontWeight: FontWeight.w400,
  );
  const boldGreenLargeTextStyle = TextStyle(
    fontSize: 28,
    color: green219653,
    fontFamily: "NunitoBold",
    fontWeight: FontWeight.w400,
  );
  return Column(
    children: [
      const Text(
        "Net Worth",
        style: TextStyle(
          fontSize: 28,
          color: black,
          fontFamily: "NunitoSemiBold",
          fontWeight: FontWeight.w400,
        ),
      ),
      Text(
        totalWorth,
        style: boldGreenLargeTextStyle,
      ),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$totalCash Cash + ",
              style: blackTextStyle,
            ),
            TextSpan(
              text: "$totalAssets Assets",
              style: greenTextStyle,
            )
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        comeptitionName,
        style: blackTextStyle,
      ),
    ],
  );
}
