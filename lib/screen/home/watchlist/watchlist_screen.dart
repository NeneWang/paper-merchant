import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:mymoney/controller/tabcontroller_screen.dart';
import 'package:mymoney/screen/home/watchlist/all_stocks_screen.dart';
import 'package:mymoney/screen/home/watchlist/home_screen.dart';

import 'package:mymoney/components/simpleListItemDesign.dart';

import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';
import 'package:mymoney/data/database.dart';
import 'package:mymoney/data/utils.dart';
import '../notification_screen.dart';

class WatchListScreen extends StatefulWidget {
  final applicationController myTabController =
      Get.put(applicationController());
  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final applicationController myTabController =
      Get.put(applicationController());

  final Database db = Database();
  List stockList = [];
  List bookmarkedList = [];

  reloadScreen() async {
    db.loadData();
    await db.syncData();
    setState(() {
      stockList = convertToListingFormat(db.userStockPrices);
    });

    setState(() {
      bookmarkedList = convertToListingFormat(db.userBookmarkPrices);
    });

    print("bookmarkedList: $bookmarkedList");
    print('stockList');
    print(stockList);
  }

  @override
  void initState() {
    super.initState();
    reloadScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          reloadScreen();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBarDesign(),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: Get.width / 20.57, top: Get.height / 178.28),
                  child: InkWell(
                    onTap: () {
                      Get.to(NotificationScreen());
                    },
                    child: SvgPicture.asset(
                      bellhome,
                    ),
                  ),
                ),
              ),
              Container(
                height: Get.height / 2.80,
                child: TabBarView(
                  controller: myTabController.controller,
                  children: [
                    tabAssetsView(
                        db.userData["cash"]?.toStringAsFixed(2) ?? "0",
                        db.userData["papel_asset_worth"]?.toStringAsFixed(2) ??
                            "0"),
                    Text(Get.height.toString()),
                    Text(Get.width.toString()),
                    Text("cj"),
                    Text("cj"),
                  ],
                ),
              ),
              Container(
                height: Get.height / 13.42,
                width: Get.width,
                child: BottomAppBar(
                  // notchMargin: 0,
                  notchMargin: 5.0,
                  color: pageBackGroundC,
                  elevation: 0,
                  child: TabBar(
                    // labelPadding: EdgeInsets.all(0),
                    // onTap: _onItemTapped,
                    labelColor: appColor,
                    controller: myTabController.controller,
                    unselectedLabelColor: black,
                    indicatorColor: appColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 2,
                    isScrollable: false,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: appColor, width: 2),
                      // insets: EdgeInsets.only(bottom: 52),
                    ),
                    tabs: myTabController.dateViewController,
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: black,
                      fontFamily: "NunitoSemiBold",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 44.57,
              ),
              Container(
                height:
                    Get.height * 1.2 /*(Get.height > 891) ? Get.height : 275*/,
                width: Get.width,
                decoration: BoxDecoration(
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
                          Text(
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
                            child: Text(
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
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: stockList.length,
                      itemBuilder: (context, index) => simpleStockListViewItem(
                        context: context,
                        title: stockList[index]["title"],
                        total: stockList[index]["totalRs"],
                      ),
                    ),
                    Padding(
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
                          Text(
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
                            child: Text(
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
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bookmarkedList.length,
                      itemBuilder: (context, index) => simpleStockListViewItem(
                        context: context,
                        title: bookmarkedList[index]["title"],
                        total: bookmarkedList[index]["totalRs"],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

lastContainerDesign(
    {String? text1,
    Color? mainColor,
    String? text2,
    String? richText1,
    String? richText2}) {
  return Container(
    width: 82 /*tablet:80*/,
    child: Row(
      children: [
        VerticalDivider(
          color: mainColor,
          thickness: 2,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text1!,
              style: TextStyle(
                fontSize: 9,
                color: black3B3C59,
                fontFamily: "NunitoBold",
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              text2!,
              style: TextStyle(
                fontSize: 12,
                color: mainColor,
                fontFamily: "NunitoSemiBold",
                fontWeight: FontWeight.w600,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: richText1,
                    style: TextStyle(
                      fontSize: 8,
                      color: black080D0A,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "(",
                    style: TextStyle(
                      fontSize: 8,
                      color: black080D0A,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: richText2,
                    style: TextStyle(
                      fontSize: 8,
                      color: mainColor,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ")",
                    style: TextStyle(
                      fontSize: 8,
                      color: black080D0A,
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
  );
}

tabAssetsView(String totalCash, String totalAssets) {
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
      Padding(
        padding: const EdgeInsets.only(top: 28),
        child: SizedBox(
          height: Get.height / 5.57,
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
                // border: Border.all(color: transPrent, width: 1),
              ),
              lineBarsData: [getRandomLineChartData()],
            ),
          ),
        ),
      ),
    ],
  );
}
