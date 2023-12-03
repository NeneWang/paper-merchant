import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:papermarket/utils/color.dart';
import 'package:papermarket/data/database.dart';

import '../../utils/utils_text.dart';

class NotificationScreen extends StatelessWidget {
  final db = Database();

  get grayE2E2E2 => null;
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
        child: FutureBuilder<List>(
          future: db.getUserTransactions(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        notificationText(
                          notificationText: "Hello",
                          textTime: "12:00",
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                )
              // ? Container(
              //     child: Text('Loaded'),
              //   )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
