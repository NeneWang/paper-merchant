import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/components/loading_placeholder.dart';

import 'package:paper_merchant/components/simpleListItemDesign.dart';
import 'package:paper_merchant/data/database.dart';
import 'package:paper_merchant/screen/home/watchlist/home_screen.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/utils/utils_text.dart';

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
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: Expanded(
                    child: FutureBuilder(
                        future: db.getShowStockAsList(filter: widget.search),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) =>
                                  simpleStockListViewItem(
                                title: snapshot.data![index]["title"],
                                total: snapshot.data![index]["totalRs"],
                                imageUrl: snapshot.data![index]["imageUrl"],
                                stockData: snapshot.data![index]["stockData"],
                                // stockData: ,
                                colorName: green,
                              ),
                            );
                          } else {
                            return const LoadingPlaceholder(
                              waitingMessage: "Loading Stocks data...",
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
