import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/controller/tabcontroller_screen.dart';
import 'package:paper_merchant/screen/home/order/executed_screen.dart';
import 'package:paper_merchant/screen/home/order/pending_screen.dart';
import 'package:paper_merchant/screen/home/watchlist/home_screen.dart';
import 'package:paper_merchant/utils/color.dart';

// ignore: must_be_immutable
class OrderScreen extends StatelessWidget {
  applicationController myTabController = Get.put(applicationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      resizeToAvoidBottomInset: false,
      appBar: appBarDesign(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: BottomAppBar(
              color: pageBackGroundC,
              elevation: 0,
              child: Center(
                child: TabBar(
                  labelColor: appColor,
                  controller: myTabController.controller1,
                  unselectedLabelColor: black,
                  indicatorColor: appColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2,
                  isScrollable: false,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: appColor, width: 2),
                    // insets: EdgeInsets.only(bottom: 52),
                  ),
                  tabs: myTabController.myTabs2,
                  labelStyle: TextStyle(
                    fontSize: 15,
                    color: black2,
                    fontFamily: "NunitoSemiBold",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: Get.height > 891
                ? Get.height / 1.312
                : Get.height / 1.394 /* tablet:Get.height / 1.34*/,
            /*601*/
            color: white,
            child: TabBarView(
              controller: myTabController.controller1,
              children: [
                PendingOrderScreen(),
                ExecutedScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
