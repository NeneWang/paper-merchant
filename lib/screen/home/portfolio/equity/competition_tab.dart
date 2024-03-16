import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/screen/home/competition_details_screen.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/data/database.dart';
import 'package:paper_merchant/components/loading_placeholder.dart';
import 'package:paper_merchant/components/small_space.dart';

class CompetitionScreenTab extends StatefulWidget {
  const CompetitionScreenTab({super.key});

  @override
  State<CompetitionScreenTab> createState() => _CompetitionScreenTabState();
}

class _CompetitionScreenTabState extends State<CompetitionScreenTab> {
  final db = Database();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    db.loadData();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {}); // Reload every 5 seconds
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCompetitionId = db.userData['current_competition'] ?? '';
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: db.getCompetitionsData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !snapshot.hasData) {
                return const LoadingPlaceholder(
                  waitingMessage: "Loading Competitions data...",
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return snapshot.data != null
                    ? Column(
                        children: [
                          const Text(
                            'Live Competitions',
                            style: TextStyle(
                              fontSize: 18,
                              color: black2,
                              fontFamily: "NunitoBold",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SmallSpace(),
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
                                  color: snapshot.data![index]
                                          ["user_is_participant"]
                                      ? greenLogo.withOpacity(0.2)
                                      : null,
                                  child: ListTile(
                                    title: Text(
                                      '${snapshot.data![index]['competition_name'] ?? 'N/A'}',
                                    ),
                                    trailing: currentCompetitionId ==
                                            snapshot.data![index]
                                                ['competition_id']
                                        ? Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: greenLogo,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Text(
                                              'Current',
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        : null,
                                    subtitle: Text(
                                        'Players: ${snapshot.data![index]['competition_participants_count']?.toString() ?? '0'}'),
                                    onTap: () {
                                      // print('Selected competition');
                                      // print(snapshot.data![index]);

                                      // Don't do anything if the selected competition is the current one as well.
                                      if (currentCompetitionId ==
                                          snapshot.data![index]
                                              ['competition_id']) {
                                        // Snackbars are used to display a message at the bottom of the screen
                                        Get.snackbar(
                                          'Can\'t select',
                                          'You are already in this competition',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: const Color.fromARGB(
                                              255, 111, 54, 244),
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CompetitionDetailsScreen(
                                            competitionData:
                                                snapshot.data![index],
                                          ),
                                        ),
                                      );
                                    },
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
