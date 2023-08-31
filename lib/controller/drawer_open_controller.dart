import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerOpen extends GetxController with SingleGetTickerProviderMixin {
  Rx<double> xOffset = 0.0.obs;
  Rx<double> yOffset = 0.0.obs;
  Rx<double> scaleFactor = 1.0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Duration duration = const Duration(milliseconds: 300);
  var isChange = false.obs;

  AnimationController? animationController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    animationController = AnimationController(vsync: this, duration: duration);
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  setQuality({xOffset, yOffset, scaleFactor}) {
    this.xOffset = xOffset;
    this.yOffset = yOffset;
    this.scaleFactor = scaleFactor;
  }
}

class ProfileController extends GetxController {
  final selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
