import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/data/database.dart';

class AccountScreen extends StatelessWidget {
  final Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: pageBackGroundC,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: () {
            db.createDefaultData();
            db.loadData();
            db.syncData();
          }(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              db.createDefaultData();
              db.loadData();
              db.syncData();
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
              return Stack(
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
                          children: [
                            Text(
                              "name: ${db.userData["name"] ?? 'name_not_set'}",
                              style: nameTextStyle,
                            ),
                            const SizedBox(
                              height: 5.14,
                            ),
                            Text("${db.userData["user_id"] ?? 'id_not_set'}",
                                style: detailsTextStyle),
                            Text(
                                "${db.userData["current_competition"] ?? 'competition_not_set'}",
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
                              onTap: () {},
                              child: leftArrowRowLink(
                                labelText: "Link with Account",
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: leftArrowRowLink(
                                labelText: "Join Competition",
                              ),
                            ),
                            InkWell(
                              onTap: () {},
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
              );
            }
          },
        ));
  }
}

leftArrowRowLink({String? labelText}) {
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
          Icons.arrow_forward,
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
