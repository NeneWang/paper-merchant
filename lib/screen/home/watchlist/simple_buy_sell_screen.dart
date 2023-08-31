import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/controller/conteiner_color_change_keypade.dart';
import 'package:mymoney/controller/drawer_open_controller.dart';
import 'package:mymoney/controller/tabcontroller_screen.dart';

import 'package:mymoney/screen/home/watchlist/toggle_design_screen.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';

import 'package:mymoney/data/database.dart';

import '../drawer_open_.dart';

final MyTabController myTabController = Get.put(MyTabController());
ColorChangeController colorChangeController = Get.put(
  ColorChangeController(),
);

const dividerComponent = Divider(
  thickness: 3,
  color: grayF2F2F2,
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
          child: Text(ticker, style: largeText),
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
                      Text(price, style: blackBoldStyle)
                    ],
                  ),
                ],
              ),
            ),
          ),
          dividerComponent,
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
                                      style: blackBoldStyle,
                                    ),
                                    TextSpan(
                                      text: snapshot.data![
                                              "shares_owned_profit_percent"] +
                                          "%",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: snapshot.data!["profit_color"],
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ")",
                                      style: blackBoldStyle,
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
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text("Loading user data..."),
                      ],
                    ),
                  );
                }
              }),
          dividerComponent,
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 33, right: 33, bottom: 16),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buyButton(
                  textLabel: "BUY",
                  onTapButton: () {
                    buyDialog(context);
                  },
                ),
                sellButton(
                  textLabel: "SELL",
                  onTapButton: () {
                    sellDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

buyDialog(context) {
  ProfileController profileController = Get.find();
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
          design1Buy(color1: appColor2F80ED),
          dividerComponent,
          design2(color2: appColor),
          design3(color2: appColor),
          dividerComponent,
          Padding(
            padding:
                const EdgeInsets.only(right: 17, left: 17, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Set Stoploss",
                  style: TextStyle(
                    color: black2,
                    fontWeight: FontWeight.w700,
                    fontFamily: "NunitoBold",
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Obx(
                  () => CupertinoSwitch(
                    activeColor: appColor,
                    value: colorChangeController.lights.value,
                    onChanged: (bool value) {
                      colorChangeController.lights.value = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          dividerComponent,
          Padding(
            padding:
                const EdgeInsets.only(right: 17, left: 17, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Set target",
                  style: TextStyle(
                    color: black2,
                    fontWeight: FontWeight.w700,
                    fontFamily: "NunitoBold",
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 36,
                ),
                Obx(
                  () => CupertinoSwitch(
                    activeColor: appColor,
                    value: colorChangeController.lights1.value,
                    onChanged: (bool value) {
                      colorChangeController.lights1.value = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          dividerComponent,
          Padding(
            padding: EdgeInsets.only(top: 39, bottom: 16),
            child: buyDropDownButton(
              textLabel: "BUY",
              onTapButton: () {
                profileController.selectedIndex.value = 1;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrawerOpenScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

sellDialog() {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(CupertinoIcons.clear),
                ),
              ],
            ),
          ),
          design1Sell(color1: redEB5757),
          dividerComponent,
          design2(color2: redEB5757),
          design3Sell(color2: redEB5757),
          dividerComponent,
          Padding(
            padding:
                const EdgeInsets.only(right: 17, left: 17, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Set Stoploss",
                  style: TextStyle(
                    color: black2,
                    fontWeight: FontWeight.w700,
                    fontFamily: "NunitoBold",
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Obx(
                  () => CupertinoSwitch(
                    activeColor: redEB5757,
                    value: colorChangeController.lights.value,
                    onChanged: (bool value) {
                      colorChangeController.lights.value = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          dividerComponent,
          Padding(
            padding:
                const EdgeInsets.only(right: 17, left: 17, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  "Set target",
                  style: TextStyle(
                    color: black2,
                    fontWeight: FontWeight.w700,
                    fontFamily: "NunitoBold",
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 36,
                ),
                Obx(
                  () => CupertinoSwitch(
                    activeColor: redEB5757,
                    value: colorChangeController.lights1.value,
                    onChanged: (bool value) {
                      colorChangeController.lights1.value = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          dividerComponent,
          Padding(
            padding: EdgeInsets.only(top: 39, bottom: 16),
            child: sellDropDownButton(
              onTapButton: () {},
              textLabel: "SELL",
            ),
          ),
        ],
      ),
    ),
  );
}

tableView() {
  return Padding(
    padding: const EdgeInsets.only(top: 14, bottom: 14),
    child: Table(
      // defaultColumnWidth: FixedColumnWidth(120),
      children: [
        TableRow(children: [
          Column(children: [
            Text(
              'Bid',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: black2,
              ),
            )
          ]),
          Column(children: [
            Text(
              'Offer',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: black2,
              ),
            )
          ]),
          Column(children: [
            Text(
              'Qty',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: black2,
              ),
            )
          ]),
          Column(children: [
            Text(
              'Offer',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: black2,
              ),
            )
          ]),
          Column(children: [
            Text(
              'Order',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: black2,
              ),
            )
          ]),
          Column(children: [
            Text(
              'Qty',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: black2,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            ),
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
        TableRow(children: [
          Column(children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: appColor2F80ED,
              ),
            )
          ]),
          Column(children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
          Column(children: [
            Text(
              '0.00',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
                color: redEB5757,
              ),
            )
          ]),
        ]),
      ],
    ),
  );
}

lineGraph() {
  return LineChart(
    LineChartData(
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 7,
      minY: 0,
      maxY: 8,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: gray7C828A,
              fontWeight: FontWeight.w400,
              fontFamily: "Nunito",
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '·11am';
              case 2:
                return '.12am';
              case 3:
                return '·1pm';
              case 4:
                return '·2pm';
              case 5:
                return '·3pm';
              case 6:
                return '.03.45.09';
            }
            return '';
          },
          margin: 0,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: gray7C828A,
              fontWeight: FontWeight.w400,
              fontFamily: "Nunito",
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '0';
              case 2:
                return '150';
              case 3:
                return '250';
              case 4:
                return '350';
              case 5:
                return '500';
              case 6:
                return '650';
              case 7:
                return '750';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xffD6D9DC),
            strokeWidth: 1,
          );
        },
        drawVerticalLine: false,
        /* getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Color(0xffD6D9DC),
                            strokeWidth: 1,
                          );
                        },*/
      ),
      lineBarsData: [
        LineChartBarData(
          dotData: FlDotData(show: false),
          spots: [
            FlSpot(0, 5),
            FlSpot(1, 4),
            FlSpot(2.5, 6),
            FlSpot(3.5, 5),
            FlSpot(4.5, 2),
            FlSpot(6.5, 4.5),
            FlSpot(7, 2.5),
          ],
          isCurved: true,
          barWidth: 1,
          colors: [
            appColor,
          ],
        ),
        LineChartBarData(
          dotData: FlDotData(show: false),
          spots: [
            FlSpot(0, 4),
            FlSpot(1, 4.9),
            FlSpot(2.5, 2),
            FlSpot(3.5, 3),
            FlSpot(4.5, 3.4),
            FlSpot(6.5, 3.5),
            FlSpot(7, 3.9),
          ],
          isCurved: true,
          barWidth: 1,
          colors: [
            redEB5757,
          ],
        ),
      ],
    ),
  );
}

design1({color1}) {
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
              ToggleScreen(color1),
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
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "+30.00",
                      style: TextStyle(
                        fontSize: 13,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "(",
                      style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "+0.72%",
                      style: TextStyle(
                        fontSize: 13,
                        color: color1,
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
}

design1Buy({color1}) {
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
              ToggleScreenBuy(color1),
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
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "+30.00",
                      style: TextStyle(
                        fontSize: 13,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "(",
                      style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "+0.72%",
                      style: TextStyle(
                        fontSize: 13,
                        color: color1,
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
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "+30.00",
                      style: TextStyle(
                        fontSize: 13,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "(",
                      style: TextStyle(
                        fontSize: 18,
                        color: black,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "+0.72%",
                      style: TextStyle(
                        fontSize: 13,
                        color: color1,
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
}

design2({color2}) {
  return Padding(
    padding: EdgeInsets.only(
        left: Get.width / 24.20 /* 17*/,
        right: Get.width / 24.20 /*17*/,
        top: 17),
    child: Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quantity",
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
                child: TextField(
                  textAlign: TextAlign.start,
                  cursorColor: black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prise",
                style: TextStyle(
                  fontSize: 13,
                  color: gray4,
                  fontFamily: "NunitoSemiBold",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 31,
                width: Get.width / 4.37 /* 94*/,
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
                    "₹2126.20",
                    style: TextStyle(
                      fontSize: 13,
                      color: black,
                      fontFamily: "NunitoBold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order",
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
                        value: myTabController.selectedValue.value,
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
                        items: myTabController.dropList.map((e) {
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
                          myTabController.setSelected(val!);
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

List sampleData = [
  {"open": 50.0, "high": 100.0, "low": 40.0, "close": 80, "volumeto": 5000.0},
  {"open": 80.0, "high": 90.0, "low": 55.0, "close": 65, "volumeto": 4000.0},
  {"open": 65.0, "high": 120.0, "low": 60.0, "close": 90, "volumeto": 7000.0},
  {"open": 90.0, "high": 95.0, "low": 85.0, "close": 80, "volumeto": 2000.0},
  {"open": 80.0, "high": 85.0, "low": 40.0, "close": 50, "volumeto": 3000.0},
];
