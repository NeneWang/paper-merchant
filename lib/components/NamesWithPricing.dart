import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:mymoney/screen/home/watchlist/toggle_design_screen.dart';
import 'package:mymoney/utils/color.dart';

class NamesWithPricing extends StatelessWidget {
  final String price;
  final String symbol;
  final Color color1;

  const NamesWithPricing({
    super.key,
    this.price = "0.00",
    this.symbol = "",
    this.color1 = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 17, bottom: 17),
      child: SizedBox(
        width: Get.width,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                    fontSize: 18,
                    color: black2,
                    fontFamily: "NunitoBold",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ToggleScreen(color1),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$" + price,
                  style: TextStyle(
                    fontSize: 18,
                    color: color1,
                    fontFamily: "NunitoBold",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "+30.00",
                        style: TextStyle(
                          fontSize: 13,
                          color: black,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "(",
                        style: TextStyle(
                          fontSize: 18,
                          color: black,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "+0.72%",
                        style: TextStyle(
                          fontSize: 13,
                          color: color1,
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: ")",
                        style: TextStyle(
                          fontSize: 18,
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
          ],
        ),
      ),
    );
  }
}
