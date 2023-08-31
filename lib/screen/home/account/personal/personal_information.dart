import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/utils/buttons_widget.dart';
import 'package:mymoney/utils/color.dart';

class PersonalInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            CupertinoIcons.back,
            color: black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: pageBackGroundC,
        title: Text(
          "Personal Information",
          style: TextStyle(
            fontSize: 25,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            color: pageBackGroundC,
            child: Padding(
              padding: EdgeInsets.only(
                  right: 29, left: 29, bottom: Get.height / 19.37, top: 9),
              child: Container(
                height: Get.height / 15.63,
                width: Get.width,
                child: Text(
                  "We get your personal information from the verification process. If you want to make changes on your personal information, contact our support.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: black485068,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height / 7),
            child: Container(
              height: Get.height / 1.35,
              width: Get.width,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      personalDesign1(
                        textLabel: "First name",
                        hintText: "Mattie",
                      ),
                      personalDesign1(
                        textLabel: "Last name",
                        hintText: "Hardwick",
                      ),
                      personalDesign1(
                        textLabel: "City",
                        hintText: "Fort Myers",
                      ),
                      personalDesign1(
                        textLabel: "ZIP/Area code",
                        hintText: "395010",
                      ),
                      personalDesign1(
                        textLabel: "Citizenship",
                        hintText: "India",
                      ),
                      /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(backgroundColor: Colors.lightBlue,),
                    ),*/

                      Padding(
                        padding: EdgeInsets.only(top: 39, bottom: 20),
                        child: buyDropDownButton(
                          textLabel: "Save",
                          onTapButton: () {
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

personalDesign1({String? textLabel, String? hintText}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Container(
      height: 76,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textLabel!,
            style: TextStyle(
              fontSize: 15,
              color: black2.withOpacity(0.6),
              fontFamily: "NunitoSemiBold",
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            cursorColor: appColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: black2,
                fontSize: 19,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w400,
              ),
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
        ],
      ),
    ),
  );
}
