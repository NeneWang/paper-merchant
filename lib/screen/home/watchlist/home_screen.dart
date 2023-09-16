import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mymoney/controller/conteiner_color_change_keypade.dart';
import 'package:mymoney/controller/drawer_open_controller.dart';
import 'package:mymoney/screen/home/account/account_screen.dart';
import 'package:mymoney/screen/home/fund/fund_screen.dart';
import 'package:mymoney/screen/home/portfolio/portfolio_screen.dart';
import 'package:mymoney/screen/home/watchlist/watchlist_screen.dart';
import 'package:mymoney/utils/color.dart';
import 'package:mymoney/utils/data.dart';
import 'package:mymoney/utils/imagenames.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    4: GlobalKey(),
  };
  ProfileController profileController = Get.put(ProfileController());

  DrawerOpen drawerOpen = Get.put(DrawerOpen());

  // ignore: missing_return
  Future<bool> systemBackButtonPressed() {
    if (navigatorKeys[profileController.selectedIndex.value]!
        .currentState!
        .canPop()) {
      navigatorKeys[profileController.selectedIndex.value]!.currentState!.pop(
          navigatorKeys[profileController.selectedIndex.value]!.currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    throw true;
  }

  @override
  Widget build(BuildContext context) {
    // print("Xscale:}");
    return Obx(
      () => AnimatedContainer(
        height: Get.height,
        width: Get.width,
        curve: Curves.bounceOut,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff40000000),
              spreadRadius: 0.5,
              blurRadius: 20,
            ),
          ],
        ),
        transform: Matrix4.translationValues(
          drawerOpen.xOffset.value,
          drawerOpen.yOffset.value,
          0,
        )..scale(drawerOpen.scaleFactor.value),
        duration: Duration(
          milliseconds: 250,
        ),
        child: WillPopScope(
          onWillPop: systemBackButtonPressed,
          child: InkWell(
            onTap: () {
              drawerOpen.xOffset.value = 0;
              drawerOpen.yOffset.value = 0;
              drawerOpen.scaleFactor.value = 1.0;
              drawerOpen.isChange(false);
            },
            child: Scaffold(
              backgroundColor: pageBackGroundC,
              resizeToAvoidBottomInset: false,
              body: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (s) => IndexedStack(
                  index: s.selectedIndex.value,
                  children: <Widget>[
                    // LogInScreen(),
                    NavigatorPage(
                      child: WatchListScreen(),
                      title: "Watch",
                      navigatorKey: navigatorKeys[0]!,
                    ),
                    NavigatorPage(
                      child: PortFolioScreen(),
                      title: "port",
                      navigatorKey: navigatorKeys[2]!,
                    ),
                    NavigatorPage(
                      child: FundScreen(),
                      title: "fund",
                      navigatorKey: navigatorKeys[3]!,
                    ),
                    NavigatorPage(
                      child: AccountScreen(),
                      title: "account",
                      navigatorKey: navigatorKeys[4]!,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: SuperFaBottomNavigationBar(),
            ),
          ),
        ),
      ),
    );
  }
}

appBarDesign() {
  ColorChangeController colorChangeController = Get.find();
  // Very important code dont erase!!
  // ignore: unused_local_variable
  DrawerOpen drawerOpen = Get.put(DrawerOpen());
  FocusNode focusNode = FocusNode();
  return AppBar(
    backgroundColor: pageBackGroundC,
    leadingWidth: 30,
    elevation: 0,
    centerTitle: true,
    title: Container(
      height: 40,
      // width: 700,
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: TextField(
        cursorColor: appColor,
        focusNode: focusNode,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: InputBorder.none,
          hintText: "Search anything",
          hintStyle: const TextStyle(
            fontSize: 14,
            color: gray9B9797,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: gray9B9797,
            size: 20,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
                width: 1,
                child: VerticalDivider(
                  color: gray9B9797,
                ),
              ),
              IconButton(
                onPressed: () {
                  focusNode.unfocus();
                  Get.bottomSheet(
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 29, left: 30, right: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Filter",
                                  style: TextStyle(
                                    color: black0D1F3C,
                                    fontFamily: "PoppinsSemiBold",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Done",
                                    style: TextStyle(
                                      color: appColor,
                                      fontFamily: "PoppinsMedium",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => MaterialButton(
                                  onPressed: () {
                                    if (colorChangeController
                                            .buttonCheck1.isTrue ||
                                        colorChangeController
                                            .buttonCheck2.isTrue) {
                                      colorChangeController.buttonCheck1(false);
                                      colorChangeController.buttonCheck2(false);
                                    }
                                    colorChangeController.buttonCheck1(true);
                                    if (colorChangeController
                                        .buttonCheck1.isTrue) {
                                      colorChangeController.isCheck[0] = true;
                                      colorChangeController.isCheck[1] = true;
                                      colorChangeController.isCheck[2] = true;
                                      colorChangeController.isCheck[3] = true;
                                    }
                                  },
                                  elevation: 0,
                                  height: 32,
                                  minWidth: 88,
                                  color:
                                      colorChangeController.buttonCheck1.isTrue
                                          ? pageBackGroundC
                                          : white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      color: colorChangeController
                                              .buttonCheck1.isTrue
                                          ? transPrent
                                          : Color(0xffDFDFDF),
                                    ),
                                  ),
                                  child: Text(
                                    "Select All",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: appColor,
                                      fontFamily: "PoppinsMedium",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Obx(
                                () => MaterialButton(
                                  onPressed: () {
                                    if (colorChangeController
                                            .buttonCheck2.isTrue ||
                                        colorChangeController
                                            .buttonCheck1.isTrue) {
                                      colorChangeController.buttonCheck2(false);
                                      colorChangeController.buttonCheck1(false);
                                    }
                                    colorChangeController.buttonCheck2(true);
                                    if (colorChangeController
                                        .buttonCheck2.isTrue) {
                                      colorChangeController.isCheck[0] = false;
                                      colorChangeController.isCheck[1] = false;
                                      colorChangeController.isCheck[2] = false;
                                      colorChangeController.isCheck[3] = false;
                                    }
                                  },
                                  elevation: 0,
                                  height: 32,
                                  minWidth: 81,
                                  color:
                                      colorChangeController.buttonCheck2.isTrue
                                          ? pageBackGroundC
                                          : white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      color: colorChangeController
                                              .buttonCheck2.isTrue
                                          ? transPrent
                                          : Color(0xffDFDFDF),
                                    ),
                                  ),
                                  child: Text(
                                    "Clear All",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: appColor,
                                      fontFamily: "PoppinsMedium",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: bottomSheetListBuild.length,
                            itemBuilder: (context, index) => Obx(
                              () => ListTile(
                                onTap: () {
                                  colorChangeController.isCheck[index] =
                                      !colorChangeController.isCheck[index];
                                },
                                contentPadding: EdgeInsets.all(0),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: pageBackGroundC,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        bottomSheetListBuild[index]["img"]),
                                  ),
                                ),
                                title: Text(
                                  bottomSheetListBuild[index]["title"],
                                  style: TextStyle(
                                    color: black0D1F3C,
                                    fontFamily: "PoppinsMedium",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19,
                                  ),
                                ),
                                trailing:
                                    colorChangeController.isCheck[index] == true
                                        ? Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: appColor,
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              color: white,
                                              size: 12,
                                            ),
                                          )
                                        : SizedBox.shrink(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    backgroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    elevation: 2,
                  );
                },
                icon: SvgPicture.asset(
                  sort,
                  color: gray9B9797,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ignore: must_be_immutable
class SuperFaBottomNavigationBar extends StatelessWidget {
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      // init: ProfileController(),
      builder: (s) => Obx(
        () => BottomNavigationBar(
          backgroundColor: gray9B9797,
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                watchList,
                color:
                    s.selectedIndex.value == 0 ? Color(0xff2F80ED) : gray9B9797,
              ),
              /* Icon(Icons.home)*/
              label: 'Watchlist',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  portFolio,
                  color: s.selectedIndex.value == 2
                      ? Color(0xff2F80ED)
                      : black.withOpacity(0.7),
                ),
                label: "PortFolio"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  fund,
                  color: s.selectedIndex.value == 3
                      ? Color(0xff2F80ED)
                      : black.withOpacity(0.7),
                ),
                label: "Fund"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  user,
                  color: s.selectedIndex.value == 4
                      ? Color(0xff2F80ED)
                      : gray9B9797,
                ),
                label: "Account"),
          ],
          currentIndex: s.selectedIndex.toInt(),
          selectedItemColor: Color(0xff2F80ED),
          selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w400,
          ),
          // unselectedItemColor: black.withOpacity(0.6),
          onTap: (index) => s.changeTabIndex(index),
        ),
      ),
    );
  }
}

class NavigatorPage extends StatelessWidget {
  final String? title;
  final Widget? child;
  final GlobalKey? navigatorKey;

  NavigatorPage({this.navigatorKey, this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return GetPageRoute(
          settings: settings,
          maintainState: false,
          fullscreenDialog: false,
          page: () => child!,

          // page: ()=>Scaffold(
          //   body: child,
          // ),
        );
      },
    );
  }
}
