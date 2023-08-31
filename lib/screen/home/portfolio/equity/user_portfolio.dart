import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';
// import 'package:mymoney/utils/data.dart';
import 'package:mymoney/data/database.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class UserPortfolio extends StatelessWidget {
  static Map<String, double> calculatePortfolioSummary(
      List<Map<String, dynamic>> portfolioData) {
    double totalInvested = 0;
    double totalProfit = 0;

    for (final data in portfolioData) {
      double priceAverage = double.parse(data["price_average"].toString());
      int count = data["count"];
      double estimatedProfit =
          double.parse(data["estimated_profit"].toString());

      totalInvested += priceAverage * count;
      totalProfit += estimatedProfit;
    }

    return {
      "totalInvested": totalInvested,
      "totalProfit": totalProfit,
    };
  }

  final Database db = Database();

  @override
  Widget build(BuildContext context) {
    db.loadData();
    final UserPortfolioData = db.userAsset;
    print("UserPorfolio Data became");
    print(UserPortfolioData);
    Map<String, double> portfolioSummary =
        calculatePortfolioSummary(UserPortfolioData);
    double totalInvested = portfolioSummary["totalInvested"]!;
    double totalProfit = portfolioSummary["totalProfit"]!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: UserPortfolioData.length,
            itemBuilder: (context, index) => holdScreenListDesign(
                bankName: UserPortfolioData[index]["symbol"],
                avgTextNum: double.parse(
                    UserPortfolioData[index]["price_average"].toString()),
                profitNum: double.parse(
                    UserPortfolioData[index]["estimated_profit"].toString()),
                qtyNum: UserPortfolioData[index]["count"]),
          ),
        ),
        Container(
          height: 90,
          width: Get.width,
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: Color(0xff40000000),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 19, right: 19, bottom: 10, top: 10),
                height: 37,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Invested",
                          style: TextStyle(
                            fontSize: 12,
                            color: black2.withOpacity(0.6),
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Return",
                          style: TextStyle(
                            fontSize: 12,
                            color: black2.withOpacity(0.6),
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          totalInvested.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 12,
                            color: black2,
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          totalProfit.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 12,
                            color: green219653,
                            fontFamily: "NunitoSemiBold",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 19,
                  right: 19,
                ),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: gray4.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String calculateProfitPercentage(double profit, double currentEquity) {
  double percentage = (profit / currentEquity) * 100;
  return "${percentage.toStringAsFixed(2)}%";
}

Color calculateProfitColor(double profit) {
  return profit >= 0 ? green219653 : redEB5757;
}

holdScreenListDesign(
    {String bankName = '',
    double avgTextNum = 0.0,
    double profitNum = 0.0,
    int qtyNum = 1}) {
  String qty = qtyNum.toString();
  String profit = profitNum.toString();
  String avgText = avgTextNum.toStringAsFixed(2);

  Color profileColor = calculateProfitColor(profitNum);
  double totalInvested = qtyNum * avgTextNum;
  String profitPercentage = calculateProfitPercentage(profitNum, totalInvested);
  String totalInvestedString = totalInvested.toStringAsFixed(2);

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
              bankName,
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
                    text: profitPercentage,
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
                    text: profit,
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
          children: [
            Row(
              children: [
                Text(
                  "Invested",
                  style: TextStyle(
                    fontSize: 8,
                    color: black.withOpacity(0.6),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 18,
                  width: 52,
                  decoration: BoxDecoration(
                    color: green219653,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      totalInvestedString,
                      style: TextStyle(
                        fontSize: 8,
                        color: white,
                        fontFamily: "NunitoSemiBold",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
