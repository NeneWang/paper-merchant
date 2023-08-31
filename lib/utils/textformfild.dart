import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color.dart';

textFromFieldDesign({String? hint, iconWidget, iconWidget1}) {
  return TextFormField(
    cursorColor: appColor,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: gray,
        fontSize: 15,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: iconWidget,
      suffixIcon: iconWidget1,
      /*Icon(
        Icons.email_outlined,
        color: gray,
      ),*/
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
    ),
  );
}

textFromFieldDesign1({String? hint, iconWidget, iconWidget1}) {
  return TextFormField(
    cursorColor: appColor,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: gray2,
        fontSize: 19,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: iconWidget,
      suffixIcon: iconWidget1,
      /*Icon(
        Icons.email_outlined,
        color: gray,
      ),*/
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
    ),
  );
}

textFromFieldDesign2({String? hint, iconWidget, iconWidget1}) {
  return TextFormField(
    cursorColor: appColor,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: gray2,
        fontSize: 19,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: iconWidget,
      suffixIcon: iconWidget1,
      /*Icon(
        Icons.email_outlined,
        color: gray,
      ),*/
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: gray1,
          width: 1,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
    ),
  );
}

textForKeypad(String textNum, colorBackGround) {
  return Container(
    height: Get.height / 14.37,
    width: Get.width / 6.63,
    decoration: BoxDecoration(
      color: colorBackGround,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        textNum,
        style: TextStyle(
          color: appColor,
          fontSize: 36,
          fontFamily: "NunitoSemiBold",
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

textFromFieldDesign3({String? label, iconWidget, iconWidget1}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      cursorColor: appColor,
      obscureText: true,
      obscuringCharacter: '●',
      style: TextStyle(
        fontSize: 12,
        color: black0D1F3C.withOpacity(0.3),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: gray2,
          fontSize: 19,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: iconWidget,
        suffixIcon: iconWidget1,
       
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE7E8EB),
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE7E8EB),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE7E8EB),
          ),
        ),
      ),
    ),
  );
}
