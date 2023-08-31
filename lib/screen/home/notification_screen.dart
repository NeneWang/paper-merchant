import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/data.dart';
import 'package:mymoney/utils/utils_text.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: pageBackGroundC,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        title: Center(
          child: Text(
            "Notification",
            style: TextStyle(
              fontSize: 19,
              color: black222222,
              fontFamily: "poppinsMedium",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: notificationList.length,
          itemBuilder: (context, index) => notificationText(
            svgUrl: notificationList[index]["img"],
            notificationText: notificationList[index]["title"],
            textTime: notificationList[index]["time"],
          ),
        ),
      ),
    );
  }
}
