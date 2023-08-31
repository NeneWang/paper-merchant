import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/imagenames.dart';

class CurrentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(benner1oderscreen),
        SizedBox(
          height: 5,
        ),
        Text(
          "You Have Not Placed Any Orders!",
          style: TextStyle(
            fontSize: 15,
            color: black,
            fontFamily: "NunitoSemiBold",
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Go to Watchlist",
          style: TextStyle(
            fontSize: 15,
            color: appColor,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
