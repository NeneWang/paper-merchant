import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/data/database.dart';
import 'package:paper_merchant/components/loading_placeholder.dart';
import 'package:paper_merchant/components/small_space.dart';

class SwtichCompetitionScreen extends StatefulWidget {
  final String currentCompetition;
  const SwtichCompetitionScreen({super.key, required this.currentCompetition});

  @override
  State<SwtichCompetitionScreen> createState() =>
      _SwtichCompetitionScreenState();
}

class _SwtichCompetitionScreenState extends State<SwtichCompetitionScreen> {
  final db = Database();
  @override
  Widget build(BuildContext context) {
    db.loadData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch Competition'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Current Competitions
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: db.getCompetitionsData(),
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
                              'Other Competitions',
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
                                  var isCurrentCompetition =
                                      snapshot.data![index]["competition_id"] ==
                                          widget.currentCompetition;
                                  // Alternative: Hide current competition
                                  // if (snapshot.data![index]['competition_id'] ==
                                  //     widget.currentCompetition) {
                                  //   return Container();
                                  // }

                                  return Container(
                                    // Disable current competition

                                    color: isCurrentCompetition
                                        ? gray.withOpacity(0.2)
                                        : null,
                                    child: ListTile(
                                      title: Text(
                                        '${snapshot.data![index]['competition_name'] ?? 'N/A'}',
                                      ),
                                      subtitle: Text(
                                          'Players: ${snapshot.data![index]['competition_participants_count']?.toString() ?? '0'}'),
                                      onTap: () async {
                                        if (isCurrentCompetition) {
                                          // Snackbar to show that this is the current competition
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'This is your current competition'),
                                            ),
                                          );
                                          return;
                                        }
                                        final successSwitch =
                                            await db.switchCompetition(
                                                snapshot.data![index]
                                                    ['competition_id']);
                                        // Pop the screen if the switch is successful
                                        if (successSwitch) {
                                          Navigator.pop(context);
                                        }
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
      ),
    );
  }
}
