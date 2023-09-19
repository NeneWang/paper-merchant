import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:papermarket/components/simpleListItemDesign.dart';
import 'package:papermarket/data/database.dart';
import 'package:papermarket/screen/home/watchlist/home_screen.dart';
import 'package:papermarket/utils/color.dart';
import 'package:papermarket/utils/utils_text.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class AllStockScreen extends StatefulWidget {
  String search;

  AllStockScreen({
    Key? key,
    this.search = "",
  }) : super(key: key);

  @override
  State<AllStockScreen> createState() => _AllStockScreenState();
}

class _AllStockScreenState extends State<AllStockScreen> {
  final db = Database();

  @override
  void initState() {
    db.populateAllStocksScreenData(filter: widget.search);
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
                        future: db.getShowStockAsList(filter: widget.search),
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
