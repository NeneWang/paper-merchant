import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paper_merchant/controller/drawer_open_controller.dart';
import 'package:paper_merchant/screen/home/account/account_screen.dart';
import 'package:paper_merchant/screen/home/portfolio/ranking_screen.dart';
import 'package:paper_merchant/screen/home/watchlist/watchlist_screen.dart';
import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/utils/imagenames.dart';
import 'package:paper_merchant/screen/home/watchlist/all_stocks_screen.dart';

import '../drawer_open_.dart';
// import 'package:paper_merchant/screen/home/watchlist/watchlist_screen.dart';

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
        decoration: const BoxDecoration(
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
        duration: const Duration(
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
                      child: TradeScreen(),
                      title: "Trade",
                      navigatorKey: navigatorKeys[0]!,
                    ),
                    NavigatorPage(
                      child: CompetitionScreen(),
                      title: "port",
                      navigatorKey: navigatorKeys[1]!,
                    ),
                    NavigatorPage(
                      child: AccountScreen(),
                      title: "account",
                      navigatorKey: navigatorKeys[2]!,
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
  // ColorChangeController colorChangeController = Get.find();
  // Very important code dont erase!!
  // ignore: unused_local_variable
  DrawerOpen drawerOpen = Get.put(DrawerOpen());
  FocusNode focusNode = FocusNode();
  // Print current path
  return AppBar(
    backgroundColor: pageBackGroundC,
    leadingWidth: 30,
    elevation: 0,
    // go back button to WatchListScreen
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
        onSubmitted: (value) => {
          // if (Get.currentRoute == "/AllStockScreen")
          //   },
          // Get.to(PortFolioScreen()),
          Get.offAll(DrawerOpenScreen()),
          Get.to(AllStockScreen(search: value)),
        },
        focusNode: focusNode,
        decoration: const InputDecoration(
          alignLabelWithHint: true,
          border: InputBorder.none,
          hintText: "Search Stocks",
          hintStyle: TextStyle(
            fontSize: 14,
            color: gray9B9797,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: gray9B9797,
            size: 20,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
                width: 1,
                child: VerticalDivider(
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
          elevation: 0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                watchList,
                color:
                    s.selectedIndex.value == 0 ? Color(0xff2F80ED) : gray9B9797,
              ),
              /* Icon(Icons.home)*/
              label: 'Trade',
            ),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  portFolio,
                  color: s.selectedIndex.value == 1
                      ? Color(0xff2F80ED)
                      : black.withOpacity(0.7),
                ),
                label: "Competition"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  user,
                  color: s.selectedIndex.value == 2
                      ? Color(0xff2F80ED)
                      : gray9B9797,
                ),
                label: "Player"),
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
