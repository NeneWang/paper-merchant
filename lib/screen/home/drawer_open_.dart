import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymoney/controller/drawer_open_controller.dart';
import 'package:mymoney/screen/home/watchlist/home_screen.dart';
import 'drawer_screen_dir/drawer_screen.dart';

// ignore: must_be_immutable
class DrawerOpenScreen extends StatelessWidget {
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
