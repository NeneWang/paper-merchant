import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:papermarket/screen/home/watchlist/all_stocks_screen.dart';
import 'screen/welcome/welcome_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/color.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("market_user");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/allStockScreen', page: () => AllStockScreen()),
      ],
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: white,
        ),
      ),
    );
  }
}
