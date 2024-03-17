import 'package:flutter/material.dart';
import 'package:get/get.dart';

class applicationController extends GetxController
    with SingleGetTickerProviderMixin {
  final List<Tab> dateViewController = <Tab>[
    const Tab(text: 'Day'),
    const Tab(text: 'Week'),
    const Tab(text: 'Month'),
    const Tab(text: 'Year'),
    const Tab(text: 'All'),
  ];
  final List<Tab> myTabs2 = <Tab>[
    Tab(text: 'Pending'),
    Tab(text: 'Executed'),
  ];
  final List<Tab> myTabs3 = <Tab>[
    Tab(text: 'EQUITY'),
    Tab(text: 'COMMODITY'),
  ];
  final List<Container> portfolioController = <Container>[
    Container(
        height: 30,
        alignment: Alignment.center,
        child: const Tab(text: 'Ranking')),
    Container(
        height: 30,
        alignment: Alignment.center,
        child: const Tab(text: 'Profits')),
    Container(
        height: 30,
        alignment: Alignment.center,
        child: const Tab(text: 'Competitions')),
  ];

  final List<Tab> weekYearContoller = <Tab>[
    // Tab(text: 'Day'),
    Tab(text: 'Week'),
    // Tab(text: 'Month'),
    Tab(text: 'Year'),
  ];
  final List<String> dropList = [
    "LIMIT",
    "SL",
    "SLM",
  ].obs;
  final List<String> dropList1 = [
    "DAY",
    "SL",
    "SLM",
  ].obs;
  var selectedValue = "LIMIT".obs;
  var selectedValue1 = "DAY".obs;

  void setSelected(String value) {
    selectedValue.value = value;
  }

  void setSelected1(String value) {
    selectedValue1.value = value;
  }

  TabController? controller;
  TabController? controller1;
  TabController? controller2;
  TabController? controller4;
  TabController? controller5;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: dateViewController.length);
    controller1 = TabController(vsync: this, length: myTabs2.length);
    controller2 = TabController(vsync: this, length: myTabs3.length);
    controller4 =
        TabController(vsync: this, length: portfolioController.length);
    controller5 = TabController(vsync: this, length: weekYearContoller.length);
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}
