import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color.dart';

const lightBlueUnderlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Color.fromARGB(255, 138, 160, 228),
  ),
);

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

inputFieldCustom(
    {String? hint, iconWidget, TextEditingController? textController}) {
  return TextFormField(
    cursorColor: appColor,
    controller: textController,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: gray2,
        fontSize: 19,
        fontFamily: "Nunito",
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: iconWidget,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
      focusedBorder: lightBlueUnderlineInputBorder,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE7E8EB),
        ),
      ),
    ),
  );
}

inputfieldDesignPassword(
    {String? hint, TextEditingController? textController}) {
  return PasswordFormField(
    textController: textController!,
    hint: hint,
  );
}

class PasswordFormField extends StatefulWidget {
  final TextEditingController textController;
  final String? hint;

  const PasswordFormField({
    super.key,
    required this.textController,
    this.hint = "",
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: appColor,
      obscureText: _obscureText,
      controller: widget.textController,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: gray2,
          fontSize: 19,
          fontFamily: "Nunito",
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(color: gray2, Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: gray2,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE7E8EB),
          ),
        ),
        focusedBorder: lightBlueUnderlineInputBorder,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffE7E8EB),
          ),
        ),
      ),
    );
  }
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
