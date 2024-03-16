import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/controller/tabcontroller_screen.dart';
import 'package:paper_merchant/screen/home/portfolio/equity/rankingTabControl.dart';
import 'package:paper_merchant/utils/color.dart';

// ignore: must_be_immutable
class RankingsScreen extends StatelessWidget {
  applicationController myTabController = Get.find();

  RankingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: RankingsTabsScreens(),
          )
        ],
      ),
    );
  }
}
