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

  @override
  Widget build(BuildContext context) {
    db.loadData();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Current Competitions
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future:
                db.getCompetitionsData(), // replace with your competitionUUID
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                                    subtitle: Text(
                                        'Players: ${snapshot.data![index]['competition_participants_count']?.toString() ?? '0'}'),
                                    onTap: () {
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
