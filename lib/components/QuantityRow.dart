import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/color.dart';

class QuantitiyRow extends StatefulWidget {
  const QuantitiyRow({
    super.key,
    required this.singularPrice,
  });

  final double singularPrice;

  @override
  State<QuantitiyRow> createState() => _QuantitiyRowState();
}

class _QuantitiyRowState extends State<QuantitiyRow> {
  double totalPrice = 0;
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalPrice = widget.singularPrice;
    quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quantity",
              style: TextStyle(
                fontSize: 13,
                color: gray4,
                fontFamily: "NunitoSemiBold",
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 31,
              width: Get.width / 4.37 /*94*/,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: const Color(0xff66000000),
                  width: 1,
                ),
              ),
              child: TextField(
                textAlign: TextAlign.start,
                // Starter value as 1
                // controller: TextEditingController(text: "1"),
                onChanged: (value) {
                  setState(() {
                    totalPrice = widget.singularPrice * double.parse(value);
                  });
                  print("Changed into :" + totalPrice.toString());
                },
                controller: quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                cursorColor: black,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total",
              style: TextStyle(
                fontSize: 13,
                color: gray4,
                fontFamily: "NunitoSemiBold",
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 31,
              width: Get.width / 4.37 /* 94*/,
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: black,
                    fontFamily: "NunitoBold",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
