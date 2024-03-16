import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/screen/auth/login/login_screen.dart';
import 'package:paper_merchant/screen/home/drawer_open_.dart';
import 'package:paper_merchant/utils/buttons_widget.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/utils/imagenames.dart';
import 'package:paper_merchant/utils/textformfild.dart';
import 'package:paper_merchant/data/database.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController reEnterPasswordController =
      TextEditingController();

  bool verifyEmail(String emailString) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(emailString);
  }

  Future<void> submit(BuildContext context) async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String reEnterPassword = reEnterPasswordController.text;

    print("Name: $name");
    print("Email: $email");
    print("Password: $password");
    print("Re Enter Password: $reEnterPassword");

    if (!verifyEmail(email)) {
      showErrorSnackBar(
          title: "Email is not valid", message: "Please enter valid email");
      return;
    }

    if (password != reEnterPassword) {
      showErrorSnackBar(
          title: "Password not match", message: "Please enter same password");
      return;
    }

    final Database db = Database();
    bool signUpSuccess = await db.signUp(
      name: name,
      email: email,
      password: password,
    );

    if (signUpSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DrawerOpenScreen(),
        ),
      );
    }
  }

  void showErrorSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackGroundC,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pageBackGroundC,
        centerTitle: true,
        title: const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 25,
            color: black2,
            fontFamily: "NunitoBold",
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: black1,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: pageBackGroundC,
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 23.45),
              child: SvgPicture.asset(signUPBenner, height: Get.height / 4.43),
            ),
          ),
          Positioned(
            top: Get.height / 3.71,
            bottom: 0.0,
            child: Container(
              height: Get.height / 1.59,
              width: Get.width,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 17.14,
                    vertical: Get.height / 22.28),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      inputFieldCustom(
                        hint: "Name",
                        textController: nameController,
                        iconWidget: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            user,
                            color: gray9B9797,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      inputFieldCustom(
                        hint: "Email",
                        textController: emailController,
                        iconWidget: const Icon(
                          Icons.email_outlined,
                          color: gray9B9797,
                          size: 27,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      inputfieldDesignPassword(
                        hint: "Password",
                        textController: passwordController,
                      ),
                      SizedBox(
                        height: Get.height / 31.83,
                      ),
                      inputfieldDesignPassword(
                          hint: "Re enter - Password",
                          textController: reEnterPasswordController),
                      SizedBox(
                        height: Get.height / 17.82,
                      ),
                      signUpButton(
                        textLabel: "Sign Up",
                        onTapButton: () {
                          // Get.to(
                          //   CreatePinScreen(),
                          // );
                          submit(context);
                        },
                      ),
                      SizedBox(
                        height: Get.height / 55.71,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Nunito",
                              color: black485068,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(
                                LogInScreen(),
                              );
                              print("Sign Up");
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 15,
                                color: appColor,
                                fontFamily: "NunitoSemiBold",
                              ),
                            ),
                          ),
                        ],
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
