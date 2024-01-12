import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallSpace extends StatelessWidget {
  const SmallSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 49.52,
    );
  }
}
