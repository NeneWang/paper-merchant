import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/data/database.dart';

class FundScreen extends StatefulWidget {
  const FundScreen({super.key});

  @override
  State<FundScreen> createState() => _FundScreenState();
}

class _FundScreenState extends State<FundScreen> {
  Database db = Database();
  double assets = 0.0;
  double cash = 0.0;
  double netWorth = 0.0;

  String assetsString = "";
  String cashString = "";
  String netWorthString = "";

  void refreshData() {
    db.loadData();
    db.syncData();
    assets = db.userData["papel_asset_worth"];
    cash = db.userData["cash"];
    netWorth = assets + cash;

    assetsString = assets.toStringAsFixed(2);
    cashString = cash.toStringAsFixed(2);
    netWorthString = netWorth.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    const boldDarkStyle = TextStyle(
      fontSize: 21,
      color: appColor,
      fontFamily: "NunitoSemiBold",
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          refreshData();
        },
        child: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              color: pageBackGroundC,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height / 14.85),
                child: const NetworthHeader(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                height: Get.height / 1.33,
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.56),
                    topRight: Radius.circular(22.56),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Get.height / 74.285,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Cash + Assets",
                        style: TextStyle(
                          fontSize: 17,
                          color: gray,
                          fontFamily: "NunitoSemiBold",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        netWorthString,
                        style: boldDarkStyle,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Get.height / 97.42,
                          left: Get.width / 25.71,
                          right: Get.width / 41.14,
                        ),
                        child: const Divider(
                          color: gray,
                          thickness: 1,
                        ),
                      ),
                      rowInformationDisplay(text1: "Cash", text2: cashString),
                      const Padding(
                        padding:
                            EdgeInsets.only(right: 10.28, left: 16, top: 10),
                        child: Divider(
                          color: gray,
                          thickness: 1,
                        ),
                      ),
                      rowInformationDisplay(
                          text1: "Assets", text2: assetsString),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            resetFundButton(
                                onTapButton: () {}, textLabel: "Reset Funds"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NetworthHeader extends StatelessWidget {
  const NetworthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Funds",
          style: TextStyle(
            fontSize: 26,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

rowInformationDisplay({String? text1, String? text2}) {
  return Padding(
    padding: EdgeInsets.only(
      left: Get.width / 17.19,
      right: Get.width / 22.63,
      top: Get.height / 89.14,
    ),
    child: Container(
      height: Get.height / 14.91,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1!,
            style: TextStyle(
              fontSize: 16,
              color: black2.withOpacity(0.6),
              fontFamily: "NunitoSemiBold",
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text2!,
            style: TextStyle(
              fontSize: 18,
              color: black2,
              fontFamily: "NunitoSemiBold",
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    ),
  );
}
