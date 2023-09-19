import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:papermarket/controller/tabcontroller_screen.dart';
import 'package:papermarket/screen/home/portfolio/equity/equity_screen.dart';
import 'package:papermarket/utils/color.dart';

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
          Container(
            height: Get.height / 1.07,
            color: white,
            child: TabBarView(
              controller: myTabController.controller2,
              children: [
                EquityScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
