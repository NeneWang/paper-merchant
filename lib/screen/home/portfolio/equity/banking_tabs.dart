import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/data/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:paper_merchant/components/loading_placeholder.dart';
import 'package:paper_merchant/components/small_space.dart';

class RankingScreenTab extends StatefulWidget {
  @override
  State<RankingScreenTab> createState() => _RankingScreenTabState();
}

class _RankingScreenTabState extends State<RankingScreenTab> {
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
            future: db.getRankingData(), // replace with your competitionUUID
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
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  ),
                                  top: BorderSide(
                                    color: Colors.grey.withOpacity(0.0),
                                    width: 1,
                                  ),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              barGroups: snapshot.data!.asMap().entries.map(
                                (entry) {
                                  int idx = entry.key;
                                  Map data = entry.value;
                                  bool isYou = data['player_id'] ==
                                      db.userData['player_id'];

                                  return BarChartGroupData(
                                    x: idx,
                                    barRods: [
                                      BarChartRodData(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(6),
                                          topRight: Radius.circular(6),
                                        ),
                                        y: _isLog
                                            ? log(
                                                data['total_worth'].toDouble())
                                            : data['total_worth'].toDouble(),
                                        width: 22,
                                        colors: [
                                          isYou ? greenLogo : lightBGBlue
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ).toList(),
                            )),
                          ),
                          CheckboxListTile(
                            title: const Text(
                              "Show as logarithmic",
                              style: TextStyle(color: greenLogo),
                            ),
                            value: _isLog,
                            onChanged: (value) {
                              setState(() {
                                _isLog = value ?? false;
                              });
                            },

                            activeColor: greenLogo, // Add this line
                          ),
                          // Make a horizontal line
                          const Divider(
                            height: 5,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                            color: greenLogo,
                          ),
                          SizedBox(
                            height: Get.height * 0.55,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: snapshot.data![index]['player_id'] ==
                                          db.userData['player_id']
                                      ? greenLogo.withOpacity(0.2)
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
      ],
    );
  }
}
