import 'package:flutter/material.dart';
import 'package:paper_merchant/data/database.dart';

class CompetitionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> competitionData;

  CompetitionDetailsScreen({Key? key, required this.competitionData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database db = Database();
    db.loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text(competitionData['competition_name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Competition Id: ${competitionData['competition_id']}'),
            Text('Description: ${competitionData['competition_description']}'),
            Text(
                'Initial Cash: ${competitionData['competition_initial_cash']}'),
            Text('Start Date: ${competitionData['competition_start_date']}'),
            Text(
                'End Date: ${competitionData['competition_end_date'] ?? 'Not set'}'),
            Text(
                'Participants: ${competitionData['competition_participants_count']}'),
            const SizedBox(height: 20),
            if (competitionData['user_is_participant'])
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  // Add your leave competition logic here
                  await db.leaveCompetition(competitionData['competition_id']);
                  Navigator.pop(context);
                },
                child: const Text('Leave Competition'),
              ),
            if (!competitionData['user_is_participant'])
              ElevatedButton(
                onPressed: competitionData['user_is_participant']
                    ? null
                    : () async {
                        // Add your join competition logic here
                        await db
                            .joinCompetition(competitionData['competition_id']);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                child: const Text('Join Competition'),
              ),
          ],
        ),
      ),
    );
  }
}
