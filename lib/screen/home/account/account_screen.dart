import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/screen/home/account/switch_competition.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/data/database.dart';
import 'package:paper_merchant/screen/welcome/welcome_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Database db = Database();

  @override
  void initState() {
    super.initState();
    db.loadData();
    db.syncData();
  }

  @override
  Widget build(BuildContext context) {
    const settingsAlignation = Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Settings",
        style: TextStyle(
          fontSize: 18,
          color: black2,
          fontFamily: "NunitoBold",
          fontWeight: FontWeight.w700,
        ),
      ),
    );
    const detailsTextStyle = TextStyle(
      fontSize: 10,
      color: black2,
      fontFamily: "NunitoSemiBold",
      fontWeight: FontWeight.w600,
    );
    const nameTextStyle = TextStyle(
      fontSize: 19,
      color: black2,
      fontFamily: "NunitoSemiBold",
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: pageBackGroundC,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              color: pageBackGroundC,
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                height: Get.height / 1.33,
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Get.height / 7.71,
                    left: Get.width / 17.14,
                    right: Get.width / 17.14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${db.userData["name"] ?? 'name_not_set'}",
                        style: nameTextStyle,
                      ),
                      const SizedBox(
                        height: 5.14,
                      ),
                      Text(
                          'Player id: ${db.userData["player_id"] ?? "player_id_not_set"}',
                          style: detailsTextStyle),
                      Text("User Id: ${db.userData["user_id"] ?? 'id_not_set'}",
                          style: detailsTextStyle),
                      Text(
                          "Current Participation Id ${db.userData["current_competition"] ?? 'competition_not_set'}",
                          style: detailsTextStyle),
                      // Show competition Name
                      const SizedBox(
                        height: 5.14,
                      ),
                      Text(
                          "Current Competition: ${db.userData["competition_name"] ?? 'competition_not_set'}",
                          style: detailsTextStyle),

                      SizedBox(
                        height: Get.height / 37.14,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height / 38.75),
                        child: settingsAlignation,
                      ),
                      SizedBox(
                        height: Get.height / 127.34,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SwtichCompetitionScreen(
                                currentCompetition:
                                    db.userData["current_competition"],
                              ),
                            ),
                          );
                        },
                        child: ReloadArrowRowLink(
                          labelText: "Switch Competition",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(WelcomeScreen());
                        },
                        child: logOffRowButton(
                          labelText: "Log off",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

ReloadArrowRowLink({String? labelText}) {
  return Container(
    height: 54,
    width: Get.width,
    margin: const EdgeInsets.only(top: 16),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: Get.height / 59.42),
    decoration: BoxDecoration(
      color: pageBackGroundC,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelText!,
          style: const TextStyle(
            fontSize: 19,
            color: black2,
            fontFamily: "NunitoSemiBold",
            fontWeight: FontWeight.w600,
          ),
        ),
        const Icon(
          Icons.find_replace_rounded,
          color: gray4,
          size: 30,
        ),
      ],
    ),
  );
}

logOffRowButton({String? labelText}) {
  return Container(
    height: 54,
    width: Get.width,
    margin: const EdgeInsets.only(top: 16),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: Get.height / 59.42),
    decoration: BoxDecoration(
      color: pageBackGroundC,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          labelText!,
          style: const TextStyle(
            fontSize: 19,
            color: black2,
            fontFamily: "NunitoSemiBold",
            fontWeight: FontWeight.w600,
          ),
        ),
        const Icon(
          // Log off icon
          Icons.logout,
          color: gray4,
          size: 30,
        ),
      ],
    ),
  );
}
