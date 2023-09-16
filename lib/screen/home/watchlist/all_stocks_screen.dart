import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/screen/home/watchlist/home_screen.dart';
import 'package:mymoney/components/simpleListItemDesign.dart';

import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/utils_text.dart';
import 'package:mymoney/data/database.dart';

// ignore: use_key_in_widget_constructors
class AllStockScreen extends StatefulWidget {
  @override
  State<AllStockScreen> createState() => _AllStockScreenState();
}

class _AllStockScreenState extends State<AllStockScreen> {
  final db = Database();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDesign(),
      backgroundColor: pageBackGroundC,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
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
                const Padding(
                  padding: EdgeInsets.only(left: 12, bottom: 18),
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
                                title: snapshot.data![index]["title"],
                                total: snapshot.data![index]["totalRs"],
                                colorName: green,
                              ),
                            );
                          } else {
                            return const Center(
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
