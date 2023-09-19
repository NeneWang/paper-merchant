import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:papermarket/utils/color.dart';

roundContainer(
    {String? textNum, Color? colorBox, Color? colorBorder, Color? textColor}) {
  return Container(
    height: Get.height / 14.85,
    width: Get.width / 2.05,
    decoration: BoxDecoration(
      color: colorBox,
      borderRadius: BorderRadius.all(
        Radius.circular(60),
      ),
      // shape: BoxShape.circle,
      border: Border.all(
        color: colorBorder == null ? transPrent : colorBorder,
        width: 2,
      ),
    ),
    child: Center(
      child: TextFormField(
        controller: _controller,
        validator: (value) {
          return value!.length <= 4 ? null : null;
        },
        readOnly: true,
        style: TextStyle(fontSize: 24, color: textColor),
        autofocus: true,
        showCursor: true,
        focusNode: _focusNode,
        cursorColor: Colors.transparent,
        cursorWidth: 0,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          // counterText: "",
        ),
      ),
    ),
  );
}

FocusNode _focusNode = new FocusNode();
TextEditingController _controller = TextEditingController();

void insertText(String myText) {
  final text = _controller.text;
  final textSelection = _controller.selection;
  final newText = text.replaceRange(
    textSelection.start,
    textSelection.end,
    myText,
  );
  final myTextLength = myText.length;
  _controller.text = newText;
  _controller.selection = textSelection.copyWith(
    baseOffset: textSelection.start + myTextLength,
    extentOffset: textSelection.start + myTextLength,
  );
}

void backspace() {
  final text = _controller.text;
  final textSelection = _controller.selection;
  final selectionLength = textSelection.end - textSelection.start;

  // There is a selection.
  if (selectionLength > 0) {
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start,
      extentOffset: textSelection.start,
    );
    return;
  }

  // The cursor is at the beginning.
  if (textSelection.start == 0) {
    return;
  }

  // Delete the previous character
  final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
  final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
  final newStart = textSelection.start - offset;
  final newEnd = textSelection.start;
  final newText = text.replaceRange(
    newStart,
    newEnd,
    '',
  );
  _controller.text = newText;
  _controller.selection = textSelection.copyWith(
    baseOffset: newStart,
    extentOffset: newStart,
  );
}

bool _isUtf16Surrogate(int value) {
  return value & 0xF800 == 0xD800;
}
