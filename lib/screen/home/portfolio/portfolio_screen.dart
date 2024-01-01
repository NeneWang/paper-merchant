import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/controller/tabcontroller_screen.dart';
import 'package:paper_merchant/screen/home/portfolio/equity/equity_screen.dart';
import 'package:paper_merchant/utils/color.dart';

// ignore: must_be_immutable
class PortFolioScreen extends StatelessWidget {
  applicationController myTabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: myTabController.controller2,
              children: [
                EquityScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
