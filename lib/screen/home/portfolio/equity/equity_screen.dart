import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/controller/tabcontroller_screen.dart';
import 'package:paper_merchant/screen/home/portfolio/equity/others_portfolio.dart';
import 'package:paper_merchant/screen/home/portfolio/equity/user_portfolio.dart';
import 'package:paper_merchant/utils/color.dart';

// ignore: must_be_immutable
class EquityScreen extends StatelessWidget {
  applicationController myTabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TabBar(
            labelColor: appColor,
            controller: myTabController.controller4,
            unselectedLabelColor: black,
            indicatorColor: appColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            // isScrollable: false,
            physics: const NeverScrollableScrollPhysics(),
            // labelPadding: EdgeInsets.only(right: 40),
            indicator: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xff40000000).withOpacity(0.1),
                  offset: Offset(0.5, 3),
                  blurRadius: 5,
                  spreadRadius: 0.2,
                ),
              ],
              borderRadius: BorderRadius.circular(40),
              color: pageBackGroundC,
            ),
            tabs: myTabController.portfolioController,
            labelStyle: const TextStyle(
              fontSize: 12,
              color: black2,
              fontFamily: "PoppinsMedium",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: myTabController.controller4,
        children: [
          UserPortfolio(),
          OthersPScreen(),
        ],
      ),
    );
  }
}
