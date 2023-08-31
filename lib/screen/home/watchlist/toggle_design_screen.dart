import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';

// ignore: must_be_immutable
class ToggleScreen extends StatelessWidget {
  Color buttonColor;

  ToggleScreen(this.buttonColor);

  ToggleController toggleController = Get.put(
    ToggleController(),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Container(
          width: 67,
          height: 18,
          decoration: BoxDecoration(
            color: Color(0xffC6C6C6).withOpacity(0.6),
            borderRadius: BorderRadius.all(
              Radius.circular(57.0),
            ),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(toggleController.xAlign.value, 0),
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: 34.94,
                  height: 18,
                  decoration: BoxDecoration(
                    color: this.buttonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(57.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleController.xAlign.value = -1;
                },
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: 34.94,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'NSE',
                      style: TextStyle(
                          color: toggleController.xAlign.value == -1
                              ? white
                              : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          fontFamily: "NunitoSemiBold"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleController.xAlign.value = 1;
                },
                child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: 34.94,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'BSE',
                      style: TextStyle(
                          color: toggleController.xAlign.value == 1
                              ? white
                              : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          fontFamily: "NunitoSemiBold"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ToggleScreenBuy extends StatelessWidget {
  Color buttonColor;

  ToggleScreenBuy(this.buttonColor);

  ToggleController toggleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Container(
          width: 67,
          height: 18,
          decoration: BoxDecoration(
            color: Color(0xffC6C6C6).withOpacity(0.6),
            borderRadius: BorderRadius.all(
              Radius.circular(57.0),
            ),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(toggleController.xAlign1.value, 0),
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: 34.94,
                  height: 18,
                  decoration: BoxDecoration(
                    color: this.buttonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(57.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleController.xAlign1.value = -1;
                },
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: 34.94,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'NSE',
                      style: TextStyle(
                          color: toggleController.xAlign1.value == -1
                              ? white
                              : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          fontFamily: "NunitoSemiBold"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleController.xAlign1.value = 1;
                },
                child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: 34.94,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'BSE',
                      style: TextStyle(
                          color: toggleController.xAlign1.value == 1
                              ? white
                              : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          fontFamily: "NunitoSemiBold"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ToggleScreenSell extends StatelessWidget {
  Color buttonColor;

  ToggleScreenSell(this.buttonColor);

  ToggleController toggleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => Container(
          width: 67,
          height: 18,
          decoration: BoxDecoration(
            color: Color(0xffC6C6C6).withOpacity(0.6),
            borderRadius: BorderRadius.all(
              Radius.circular(57.0),
            ),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(toggleController.xAlign2.value, 0),
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: 34.94,
                  height: 18,
                  decoration: BoxDecoration(
                    color: this.buttonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(57.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleController.xAlign2.value = -1;
                },
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: 34.94,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'NSE',
                      style: TextStyle(
                          color: toggleController.xAlign2.value == -1
                              ? white
                              : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          fontFamily: "NunitoSemiBold"),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  toggleController.xAlign2.value = 1;
                },
                child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: 34.94,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'BSE',
                      style: TextStyle(
                          color: toggleController.xAlign2.value == 1
                              ? white
                              : black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                          fontFamily: "NunitoSemiBold"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleController extends GetxController {
  Rx<double> xAlign = 1.0.obs;
  Rx<double> xAlign1 = 1.0.obs;
  Rx<double> xAlign2 = 1.0.obs;

  @override
  void onInit() {
    xAlign.value = -1.0;
    xAlign1.value = -1.0;
    xAlign2.value = -1.0;
    // TODO: implement onInit
    super.onInit();
  }
}
