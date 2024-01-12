import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:papermarket/utils/color.dart';
import 'package:papermarket/utils/data.dart';
import 'package:papermarket/data/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:papermarket/components/loading_placeholder.dart';
import 'package:papermarket/components/small_space.dart';

class OthersPScreen extends StatefulWidget {
  @override
  State<OthersPScreen> createState() => _OthersPScreenState();
}

class _OthersPScreenState extends State<OthersPScreen> {
  final db = Database();
  bool _isLog = true;

  @override
  Widget build(BuildContext context) {
    db.loadData();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future:
                db.getCompetitorsData(), // replace with your competitionUUID
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPlaceholder(
                  waitingMessage: "Loading competitors data...",
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.data != null
                    ? Column(
                        children: [
                          const SmallSpace(),
                          SizedBox(
                            height: Get.height * 0.15,
                            child: BarChart(BarChartData(
                              titlesData: FlTitlesData(
                                show: false,
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              gridData: FlGridData(
                                show: false,
                              ),
                              barGroups: snapshot.data!.asMap().entries.map(
                                (entry) {
                                  int idx = entry.key;
                                  Map data = entry.value;

                                  return BarChartGroupData(
                                    x: idx,
                                    barRods: [
                                      BarChartRodData(
                                        y: _isLog
                                            ? log(
                                                data['total_worth'].toDouble())
                                            : data['total_worth'].toDouble(),
                                        width: 22,
                                        borderRadius: BorderRadius.zero,
                                        colors: [
                                          data['player_id'] ==
                                                  db.userData['player_id']
                                              ? Colors.lightGreen
                                              : Colors.grey.withOpacity(
                                                  0.5) // 50% opacity
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            )),
                          ),
                          CheckboxListTile(
                            title: Text("Show as logarithmic"),
                            value: _isLog,
                            onChanged: (value) {
                              setState(() {
                                _isLog = value ?? false;
                              });
                            },

                            activeColor: Colors.green, // Add this line
                          ),
                          SizedBox(
                            height: Get.height * 0.55,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: snapshot.data![index]['player_id'] ==
                                          db.userData['player_id']
                                      ? Colors.lightGreen.withOpacity(0.2)
                                      : null,
                                  child: ListTile(
                                    title: Text(
                                      '${snapshot.data![index]['name'] ?? 'N/A'}',
                                    ),
                                    subtitle: Text(
                                        'Total Worth: ${snapshot.data![index]['total_worth']?.toString() ?? 'N/A'}'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const Center(child: Text('No data'));
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: bookedListPageBuildDesign.length,
            itemBuilder: (context, index) => bookedListDesign(
              ltp: bookedListPageBuildDesign[index]["ltp"],
              bankName: bookedListPageBuildDesign[index]["bankName"],
              avgText: bookedListPageBuildDesign[index]["avgText"],
              profileColor: bookedListPageBuildDesign[index]["profileColor"],
              profileText1: bookedListPageBuildDesign[index]["profileText1"],
              profileText2: bookedListPageBuildDesign[index]["profileText2"],
              qty: bookedListPageBuildDesign[index]["qty"],
            ),
          ),
        ),
      ],
    );
  }
}

bookedListDesign({
  String? qty,
  String? bankName,
  String? avgText,
  String? profileText1,
  String? profileText2,
  Color? profileColor,
  String? ltp,
}) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 12),
    margin: EdgeInsets.only(left: 12, right: 12, top: 20),
    height: 75,
    width: Get.width,
    decoration: BoxDecoration(
      color: Color(0xffF4F7FB),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xff26000000).withOpacity(0.1),
          spreadRadius: 0.1,
          blurRadius: 3,
          offset: Offset(0.5, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "QTY:",
                    style: TextStyle(
                      fontSize: 8,
                      color: black.withOpacity(0.6),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: qty,
                    style: TextStyle(
                      fontSize: 8,
                      color: black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              bankName!,
              style: TextStyle(
                fontSize: 12,
                color: black,
                fontFamily: "NunitoSemiBold",
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Avg. $avgText",
              style: TextStyle(
                fontSize: 10,
                color: gray4,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Profit",
              style: TextStyle(
                fontSize: 10,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: profileText1,
                    style: TextStyle(
                      fontSize: 11,
                      color: profileColor,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: "(",
                    style: TextStyle(
                      fontSize: 11,
                      color: black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: profileText2,
                    style: TextStyle(
                      fontSize: 11,
                      color: profileColor,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ")",
                    style: TextStyle(
                      fontSize: 11,
                      color: black,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "LTP",
                style: TextStyle(
                  fontSize: 10,
                  color: black.withOpacity(0.6),
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              ltp!,
              style: TextStyle(
                fontSize: 11,
                color: black.withOpacity(0.6),
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
