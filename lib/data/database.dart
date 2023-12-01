import 'package:get/get.dart';
import 'package:papermarket/data/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';
import 'package:fuzzy/fuzzy.dart';

import '../utils/color.dart';

// reference our box
final _myBox = Hive.box("market_user");
const backendAPI = "https://crvmb5tnnr.us-east-1.awsapprunner.com";

String generateShortGuid(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final guid =
      List.generate(length, (index) => chars[random.nextInt(chars.length)]);
  return guid.join();
}

class Database {
  Map<dynamic, dynamic> userData = {};
  List<Map<dynamic, dynamic>> userPortfolio = [];

  // For quick reference
  Map<dynamic, dynamic> userStockPrices = {};
  Map<dynamic, dynamic> userBookmarkPrices = {};
  List<String> searchHistory = ["GOOGL"];
  List<String> ticketNames = [];

  Map<dynamic, dynamic> showStockData =
      {}; //The stocks being shown in the watchlist

  void createDefaultData() {
    userData = {
      "name": "No User Logged in.",
      "user_id": "-",
      "is_connected": "false",
      "current_competition": "-",
      "player_id": "92cb1815-bbc7-47aa-aba4-4788425b0524",
      "cash": 0.00,
      "papel_asset_worth": 0.0,
      "saved_email": "",
      "saved_password": "",
      "auto_login": false,
    };

    userBookmarkPrices = {
      "META": {
        "Adj Close": 297.989990234375,
        "Close": 297.989990234375,
        "High": 299.1499938964844,
        "Low": 288.17999267578125,
        "Open": 288.5799865722656,
        "Volume": 20207100
      },
      "AAPL": {
        "Adj Close": 184.1199951171875,
        "Close": 184.1199951171875,
        "High": 184.89999389648438,
        "Low": 179.5,
        "Open": 179.6999969482422,
        "Volume": 52365100
      }
    };

    userPortfolio = [];

    userStockPrices = {
      "AAPL": {
        "Adj Close": 184.1199951171875,
        "Close": 184.1199951171875,
        "High": 184.89999389648438,
        "Low": 179.5,
        "Open": 179.6999969482422,
        "Volume": 52365100
      },
      "ACN": {
        "Adj Close": 323.45001220703125,
        "Close": 323.45001220703125,
        "High": 324.3699951171875,
        "Low": 319.55999755859375,
        "Open": 320.3900146484375,
        "Volume": 1525000
      }
    };

    ticketNames = [];
    _myBox.put("userData", userData);
  }

  void logOff() {
    _myBox.delete("userData");
    _myBox.delete("userPortfolio");
    _myBox.delete("userBookmarkPrices");
    _myBox.delete("userStockPrices");
    _myBox.delete("ticketNames");
  }

  void loginWithDemo() {}

  void loadData() {
    // If userData doesnt exist then create it
    if (_myBox.get("userData") == null) {
      createDefaultData();
    }

    if ((_myBox.get("userPortfolio") == null ||
            _myBox.get("userPortfolio").isEmpty) ||
        (_myBox.get("userBookmarkPrices") == null ||
            _myBox.get("userBookmarkPrices").isEmpty) ||
        (_myBox.get("userStockPrices") == null ||
            _myBox.get("userStockPrices").isEmpty)) {
      _myBox.put("userPortfolio", userPortfolio);
      _myBox.put("userBookmarkPrices", userBookmarkPrices);
      _myBox.put("userStockPrices", userStockPrices);
      // syncData();
    }

    if (_myBox.get("ticketNames") == null ||
        _myBox.get("ticketNames").isEmpty) {
      getStockNames();
    } else {
      ticketNames = _myBox.get("ticketNames");
    }

    userData = _myBox.get("userData");
    List<dynamic> userPortfolioData = _myBox.get("userPortfolio");
    userPortfolio = [];
    for (var asset in userPortfolioData) {
      if (asset is Map<String, dynamic>) {
        userPortfolio.add(asset);
      }
    }

    if (_myBox.get("userBookmarkPrices") == null ||
        _myBox.get("userBookmarkPrices").isEmpty) {
      _myBox.put("userBookmarkPrices", userBookmarkPrices);
      _myBox.put("userStockPrices", userStockPrices);
    }
    userBookmarkPrices = _myBox.get("userBookmarkPrices");
    userStockPrices = _myBox.get("userStockPrices");
  }

  Map<dynamic, dynamic> getuserPortfolio(String userPortfolioSymbol) {
    for (var asset in userPortfolio) {
      if (asset["symbol"] == userPortfolioSymbol) {
        return asset;
      }
    }
    return {};
  }

  int updateuserPortfolioCount(String userPortfolioSymbol, int increaseBy) {
    for (var asset in userPortfolio) {
      if (asset["symbol"] == userPortfolioSymbol) {
        if (asset["count"] + increaseBy < 0) {
          return asset["count"] - increaseBy;
        }
        asset["count"] += increaseBy;
        return asset["count"];
      }
    }
    return 0;
  }

  Future<List> getTickerTransactions(String symbol) async {
    final player_id = userData["player_id"];

    final getTickerTransactionsURL =
        "$backendAPI/player_transactions/$player_id"; // Replace with actual API URL

    final response = await http.get(Uri.parse(
        '$backendAPI/player_transactions/$player_id?stock_name=$symbol'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print("Failed to fetch ticker transactions");
      print("FAiled with status code ${response.statusCode}");
      print("api: $getTickerTransactionsURL");
      print("body: ${jsonEncode(<String, String>{
            'player_id': userData["player_id"],
            'symbol': symbol,
          })}");
      return [];
    }
  }

  Future<Map<String, dynamic>> getDetailsShare(
      String symbol, String price) async {
    try {
      loadData();

      final test_if_data_exists = getuserPortfolio(symbol);
      if (!test_if_data_exists.containsKey("count")) {
        await syncData();
      }

      final userPortfolioData = getuserPortfolio(symbol);

      final double currentSymbolPrice = double.parse(price);

      final int count = userPortfolioData["count"];
      final double averagePrice = userPortfolioData["price_average"];
      final double totalWorth = currentSymbolPrice * count;
      final double profit = totalWorth - (averagePrice * count);
      final double profitPercent = (profit / (averagePrice * count)) * 100;

      final res = {
        "shares_owned": count.toString(),
        "shares_owned_worth": totalWorth.toStringAsFixed(2),
        "shares_owned_profit": profit.toStringAsFixed(2),
        "shares_owned_profit_percent": profitPercent.toStringAsFixed(2),
        "shares_owned_average_price": averagePrice.toStringAsFixed(2),
        "profit_color": profit > 0 ? green219653 : redEB5757,
        "user_cash": userData["cash"].toStringAsFixed(2),
      };
      return res;
    } catch (e) {
      // print("error", e);

      final res = {
        "shares_owned": "0",
        "shares_owned_worth": "-",
        "shares_owned_profit": "-",
        "shares_owned_profit_percent": "-",
        "shares_owned_average_price": "-",
        "profit_color": black,
        "user_cash": userData["cash"].toStringAsFixed(2),
      };
      return res;
    }
  }

  Future<List<Map<String, dynamic>>> getShowStockAsList(
      {String filter = ""}) async {
    if (showStockData.isEmpty || filter.isNotEmpty) {
      await populateAllStocksScreenData(filter: filter);
    }

    return convertToListingFormat(showStockData);
  }

  Future populateAllStocksScreenData({String filter = "", count = 10}) async {
    // get the top 10 stocks from ticket names and request api to include their data on them.

    if (_myBox.get("ticketNames") == null ||
        _myBox.get("ticketNames").isEmpty) {
      await getStockNames();
    } else {
      ticketNames = _myBox.get("ticketNames");
    }

    List<String> result = [];

    if (filter.isNotEmpty || filter != "") {
      final fuse = Fuzzy(ticketNames);
      final fuzzyResults = fuse.search(filter);
      for (var element in fuzzyResults) {
        result.add(element.item);
      }
    } else {
      result = ticketNames;
    }

    final minCount = min<int>(count, result.length);

    final int limitCount = min<int>(count, minCount);

    final stocksToLookup = result.sublist(0, limitCount);

    showStockData = await researchMultiple(stocksToLookup);

    // print("show stock data");
    // print(showStockData);
    return;
  }

  Future<void> purchaseStock(String ticker_symbol,
      {int count = 1, double price = 100}) async {
    const postUrl = "$backendAPI/api/buy";

    // update userCash
    if (!(price * count > userData["cash"])) {
      userData["cash"] -= price * count;
      updateuserPortfolioCount(ticker_symbol, count);

      // Update the stock names
      if (!ticketNames.contains(ticker_symbol)) {
        ticketNames.add(ticker_symbol);

        userStockPrices.addAll({
          ticker_symbol: {
            "Adj Close": price,
            "Close": price,
            "High": price,
            "Low": price,
            "Open": price,
            "Volume": 0
          }
        });

        _myBox.put("ticketNames", ticketNames);
        _myBox.put("userStockPrices", userStockPrices);
      }

      // Update the userPortfolio
      _myBox.put("userPortfolio", userPortfolio);
    }

    final response = await http.post(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "player_id": userData["player_id"],
        "symbol": ticker_symbol,
        "count": count,
        "price": price,
      }),
    );

    if (response.statusCode == 200) {
      if (response.body.contains("Not enough cash")) {
        Get.snackbar(
          "Failed",
          "Not enough cash to purchase $ticker_symbol share",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      await syncData();
      Get.snackbar("Success", "$ticker_symbol share purchased",
          backgroundColor: green219653,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    } else {
      Get.snackbar("Failed", "Failed to purchase $ticker_symbol share",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
  }

  Future<void> sellStock(String ticker_symbol,
      {int count = 1, double price = 100}) async {
    // Create post request of model:
    // class AssetPurchase(BaseModel):
    // player_id: str
    // symbol: str
    // count: int
    // price: float
    // Into api: "${backendAPI}/api/sell";

    // Make internal changes monetarily

    final countStocks = updateuserPortfolioCount(ticker_symbol, -count);
    // update userCash
    if (countStocks >= 0) {
      userData["cash"] += price * count;

      // Update the stock names
      if (countStocks == 0) {
        ticketNames.remove(ticker_symbol);
        userStockPrices.remove(ticker_symbol);

        _myBox.put("ticketNames", ticketNames);
        _myBox.put("userStockPrices", userStockPrices);
      }

      // Update the userPortfolio
      _myBox.put("userPortfolio", userPortfolio);
    }

    const postUrl = "$backendAPI/api/sell";

    final response = await http.post(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "player_id": userData["player_id"],
        "symbol": ticker_symbol,
        "count": count,
        "price": price,
      }),
    );

    if (response.statusCode == 200) {
      if (response.body.contains("Not enough")) {
        Get.snackbar(
          "Failed",
          "Not enough shares to sell $ticker_symbol share",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      } else {
        await syncData();
        Get.snackbar("Success", "$ticker_symbol share sold",
            backgroundColor: green219653,
            colorText: white,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    } else {
      // print("Purchase stock failed");
      print(response.body);
      return;
    }
  }

  Future<Map<dynamic, dynamic>> researchMultiple(
      List<String> stocksNames) async {
    const multipleAPI = "$backendAPI/api/get_prev_data_multiple";
    final response = await http.post(
      Uri.parse(multipleAPI),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(stocksNames),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print("Failed to fetch stock names");
      print("FAiled with status code ${response.statusCode}");
      print("api: $multipleAPI");
      print("body: $stocksNames");

      return {};
    }
  }

  Future getStockNames() async {
    const stockAPI = "$backendAPI/api/stickers"; // Replace with actual API URL
    final response = await http.get(Uri.parse(stockAPI));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // print("tickets obtained");
      // print(responseData);
      final resticketNames = responseData["tickers"];
      for (final ticket in resticketNames) {
        if (ticket is String) {
          ticketNames.add(ticket);
        }
      }

      _myBox.put("ticketNames", ticketNames);
      print(ticketNames[0]);
      return;
    } else {
      print("Failed to fetch ticker names");
      print("FAiled with status code ${response.statusCode}");
      print("api: $stockAPI/api/stickers");
      return;
    }
  }

  Future syncData() async {
    final playerId = userData["player_id"];

    if (playerId == null) {
      print("attempting to fix null player id by loading data");
      loadData();
      print("data loaded");
      print("player id: ${userData["player_id"]}");
    }

    if (playerId != null) {
      final assetsUrl =
          "$backendAPI/api/assets/$playerId"; // Replace with actual API URL

      // Make API call using your pr eferred HTTP client (e.g., http package)
      // Example using http package:
      final response = await http.get(Uri.parse(assetsUrl));

      // print("body from " + assetsUrl);
      // print(response.body);
      // Process the API response and print assets
      if (response.statusCode == 200) {
        final assetsData = json.decode(response.body);
        userPortfolio = []; //Empty the userData before
        for (var asset in assetsData) {
          if (asset is Map<String, dynamic>) {
            userPortfolio.add(asset);
          }
        }
      } else {
        print("Failed to fetch assets");
      }

      _myBox.put("userPortfolio", userPortfolio);

      const getHighlightURL =
          "$backendAPI/api/get_highlight_today"; // Replace with actual API URL

      final bookmarks = ["AAPL", "JPM", "MSFT", "EBAY", "SHOP"];
      final headers = <String, String>{
        'Content-Type': 'application/json',
      };

      final queryParams = <String, String>{
        'player_id': playerId,
      };

      final uri =
          Uri.parse(getHighlightURL).replace(queryParameters: queryParams);

      final response_2 = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(bookmarks),
      );

      if (response.statusCode == 200) {
        // Successful response
        final responseData = jsonDecode(response_2.body);
        // Process responseData as needed
        userBookmarkPrices = responseData["bookmarks"];
        userStockPrices = responseData["stocks"];

        userData["papel_asset_worth"] =
            responseData["papel_asset_worth"].toDouble();
        userData["cash"] = responseData["user_cash"].toDouble();
        userData["name"] = responseData["user_name"];
        userData["user_id"] = responseData["user_id"];
        userData["current_competition"] = responseData["competition_id"];

        _myBox.put("userBookmarkPrices", userBookmarkPrices);
        _myBox.put("userStockPrices", userStockPrices);
        _myBox.put("userData", userData);
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } else {
      print("Player ID is missing");
      print(userData);
    }
  }

  void saveEmailPassword(String email, String password) {
    userData["saved_email"] = email;
    userData["saved_password"] = password;
    _myBox.put("userData", userData);
  }

  Future<bool> login(
      {required String email,
      required String password,
      bool rememberAccount = false}) async {
    const loginURL = "$backendAPI/login"; // Replace with actual API URL

    // Make API call using your preferred HTTP client (e.g., http package)
    // Example using http package:

    if (rememberAccount) {
      saveEmailPassword(email, password);
    }

    final response = await http.post(
      Uri.parse(loginURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    // Debug
    print("login requested");
    print(loginURL);
    print(email);
    print(password);
    print(response.body);

    // Process the API response and return true/false
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      userData["player_id"] = responseData["player_id"];
      userData["name"] = responseData["user_name"];
      userData["user_id"] = responseData["user_id"];
      userData["current_competition"] = responseData["competition_id"];
      userData["cash"] = responseData["user_cash"].toDouble();
      userData["papel_asset_worth"] =
          responseData["papel_asset_worth"].toDouble();
      _myBox.put("userData", userData);

      Get.snackbar(
        "Success",
        "Successfully logged in",
        backgroundColor: green219653,
        colorText: white,
        duration: const Duration(seconds: 1),
      );

      return true;
    } else {
      Get.snackbar("Failed", "Failed to login",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM);
      print("Failed to login");
      return false;
    }
  }

  Future<bool> signUp(
      {required name, required email, required password}) async {
    const signUpURL = "$backendAPI/signup"; // Replace with actual API URL
    final response = await http.post(
      Uri.parse(signUpURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        "competition_id": ""
      }),
    );

    print(response.body);

    // Process the API response and return true/false
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      userData["player_id"] = responseData["player_id"];
      userData["name"] = responseData["user_name"];
      userData["user_id"] = responseData["user_id"];
      userData["current_competition"] = responseData["competition_id"];
      userData["cash"] = responseData["user_cash"].toDouble();
      userData["papel_asset_worth"] =
          responseData["papel_asset_worth"].toDouble();
      _myBox.put("userData", userData);

      Get.snackbar(
        "Success",
        "Successfully Creating the Account and logged in",
        backgroundColor: green219653,
        colorText: white,
        duration: const Duration(seconds: 1),
      );

      return true;
    } else {
      Get.snackbar("Failed", "Failed to sign up",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM);
      print("Failed to login");
      return false;
    }
  }
}
