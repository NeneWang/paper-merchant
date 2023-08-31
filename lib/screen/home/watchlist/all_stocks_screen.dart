import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/home/watchlist/home_screen.dart';
import 'package:mymoney/components/simpleListItemDesign.dart';

import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/utils_text.dart';
import 'package:mymoney/data/database.dart';

class AllStockScreen extends StatelessWidget {
  final db = Database();

  @override
  Widget build(BuildContext context) {
    // db.loadData();
    db.populateAllStocksScreenData();

    return Scaffold(
      appBar: appBarDesign(),
      backgroundColor: pageBackGroundC,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 23,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 18),
                  child: Text(
                    "All Stocks",
                    style: TextStyle(
                      fontSize: 18,
                      color: black0D1F3C,
                      fontFamily: "NunitoBold",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Expanded(
                    child: FutureBuilder(
                        future: db.getShowStockAsList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) =>
                                  simpleStockListViewItem(
                                image: "",
                                title: snapshot.data![index]["title"],
                                subTitle: "",
                                total: snapshot.data![index]["totalRs"],
                                stock1: "",
                                stock2: "",
                                colorName: green,
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
