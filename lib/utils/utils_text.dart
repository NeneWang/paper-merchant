import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'color.dart';

notificationText({String? svgUrl, String? notificationText, String? textTime}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: appColor,
          maxRadius: 24,
          child: SvgPicture.asset(svgUrl!),
        ),
        Container(
          width: 214,
          child: Text(
            notificationText!,
            maxLines: 2,
            style: TextStyle(
              fontSize: 14,
              color: black,
              fontFamily: "PoppinsRegular",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          textTime!,
          style: TextStyle(
            fontSize: 14,
            color: grayABABAB,
            fontFamily: "PoppinsRegular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
