import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:papermarket/utils/imagenames.dart';
import 'package:papermarket/utils/color.dart';

class LoadingPlaceholder extends StatelessWidget {
  final String waitingMessage;

  const LoadingPlaceholder({
    Key? key,
    this.waitingMessage = "", // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            appLogo,
            height: Get.height / 4.95,
            width: Get.width / 2.76,
          ),
          const SizedBox(height: 20), // Adjust as needed
          const SizedBox(height: 20), // Adjust as needed
          const SpinKitWave(
            color: greenLogo,
            size: 50.0,
          ),
          const SizedBox(height: 20), // Adjust as needed
          Text(waitingMessage), // Add this line
        ],
      ),
    );
  }
}
