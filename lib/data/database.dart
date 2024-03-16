import 'package:get/get.dart';
import 'package:paper_merchant/data/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';
import 'package:fuzzy/fuzzy.dart';

import '../utils/color.dart';

// reference our box
final _myBox = Hive.box("market_user");
// const backendAPI = "https://crvmb5tnnr.us-east-1.awsapprunner.com";
const backendAPI = "http://127.0.0.1:8000";

String generateShortGuid(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final guid =
      List.generate(length, (index) => chars[random.nextInt(chars.length)]);
  return guid.join();
}

class Database {
  Map<dynamic, dynamic> userData = {};
  Map<dynamic, dynamic> persistent_data = {};
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
      "auto_login": false,
      "competition_name": "Universal Competition",
    };

    persistent_data = {
      "saved_email": "",
      "saved_password": "",
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

  void createDefaultPersistentData() {
    persistent_data = {
      "saved_email": "",
      "saved_password": "",
    };
    _myBox.put("persistent_data", persistent_data);
  }

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

// Replace with actual API URL

    final response = await http.get(Uri.parse(
        '$backendAPI/player_transactions/$player_id?stock_name=$symbol'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      print("Failed to fetch ticker transactions");
      return [];
    }
  }

  Future<List> getUserTransactions() async {
    // if recent transactions are empty then fetch them
    String playerId = userData["player_id"];

    playerId = userData["player_id"];
    final transactionsUrl =
        "$backendAPI/player_transactions/$playerId?limit=10&offset=0"; // Replace with actual API URL
    final res_transactions = await http.get(Uri.parse(transactionsUrl));

    if (res_transactions.statusCode == 200) {
      return jsonDecode(res_transactions.body);
    } else {
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

  Future<List<Map<String, dynamic>>> getCompetitionsData() async {
    var userId = userData["user_id"];

    var competitorsAPI = "$backendAPI/api/competitions";
    List<Map<String, dynamic>> competitorsDataFormat = [];

/**
 * 
    final response = await http.get(Uri.parse(
        '$backendAPI/player_transactions/$player_id?stock_name=$symbol'));
 */
    final response = await http.get(Uri.parse(competitorsAPI));

    if (response.statusCode == 200) {
      final competitorsData = json.decode(response.body) as List;
      for (var competitorData in competitorsData) {
        if (competitorData is Map<String, dynamic>) {
          competitorsDataFormat.add({
            "competition_id": competitorData["competition_id"],
            "competition_name": competitorData["competition_name"],
            "competition_description":
                competitorData["competition_description"],
            "competition_initial_cash":
                competitorData["competition_initial_cash"],
            "competition_start_date": competitorData["competition_start_date"],
            "competition_end_date": competitorData["competition_end_date"],
            "competition_participants":
                competitorData["competition_participants"],
            "competition_participants_count":
                competitorData["competition_participants_count"],
            "user_is_participant":
                competitorData["competition_participants_guid"]
                    .contains(userId),
            "competition_has_key": false,
          });
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return competitorsDataFormat;
  }

  Future<List<Map<String, dynamic>>> getRankingsData() async {
    // const competitorUuid = "7bc69deb-b1b4-4d45-aab1-43ce2d9caf8b";
    var competitorUuid = userData["current_competition"];
    var competitorsAPI = "$backendAPI/api/competitors/$competitorUuid";
    List<Map<String, dynamic>> competitorsDataFormat = [];

    final response = await http.get(Uri.parse(competitorsAPI));
    if (response.statusCode == 200) {
      final competitorsData = json.decode(response.body) as List;
      for (var competitorData in competitorsData) {
        if (competitorData is Map<String, dynamic>) {
          competitorsDataFormat.add({
            "player_id": competitorData["player_id"],
            "name": competitorData["name"],
            "total_worth": competitorData["total_worth"],
          });
        }
      }

      // Sort using total_worth reverse
      competitorsDataFormat
          .sort((a, b) => a["total_worth"].compareTo(b["total_worth"]));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return competitorsDataFormat;
  }

  /// Returns a list of all the competitions the user is participating in.

  Future<bool> joinCompetition(String competitionUuid, {String? userId}) async {
    userId ??= userData["user_id"];

    final joinCompetitionURL =
        "$backendAPI/api/join/$competitionUuid/$userId"; // Replace with actual API URL

    final response = await http.get(
      Uri.parse(joinCompetitionURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      userData["current_competition"] = competitionUuid;
      _myBox.put("userData", userData);
      Get.snackbar(
        "Success",
        "Successfully joined competition",
        backgroundColor: green219653,
        colorText: white,
        duration: const Duration(seconds: 1),
      );
      return true;
    } else {
      Get.snackbar("Failed", "Failed to join competition",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<bool> leaveCompetition(String competitionUuid) async {
    final userId = userData["user_id"];
    const leaveCompetitionURL = "$backendAPI/api/leave_competition";

    final response = await http.post(
      Uri.parse(leaveCompetitionURL),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "competition_id": competitionUuid,
        "user_id": userId,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      userData["current_competition"] = responseData["competition_id"];
      _myBox.put("userData", userData);
      Get.snackbar(
        "Success",
        "Successfully left competition",
        backgroundColor: green219653,
        colorText: white,
        duration: const Duration(seconds: 1),
      );
      return true;
    } else {
      Get.snackbar("Failed", "Failed to leave competition",
          backgroundColor: redEB5757,
          colorText: white,
          snackPosition: SnackPosition.BOTTOM);
      print("Failed to leave competition");
      return false;
    }
  }

  /// Switches the current competition of the user.
  ///
  /// Takes a [competitionUuid] as the identifier of the competition to switch to.
  /// Returns `true` if the operation is successful, `false` otherwise.
  Future<bool> switchCompetition(String competitionUuid) async {
    final userId = userData["user_id"];
    final switchCompetitionURL =
        "$backendAPI/api/switch_competition/$competitionUuid/$userId"; // Replace with actual API URL

    // Use Get request to the backend to switch the competition
    final response = await http
        .get(Uri.parse(switchCompetitionURL), headers: <String, String>{
      'Content-Type': 'application/json',
    });

    return handleLoginWithReportData(response);
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

      final response = await http.get(Uri.parse(assetsUrl));

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
    Map<dynamic, dynamic> persistent_data = {};
    persistent_data["saved_email"] = email;
    persistent_data["saved_password"] = password;
    _myBox.put("persistent_data", persistent_data);
    print("saved email and password");
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

    // Process the API response and return true/false
    return handleLoginWithReportData(response);
  }

  // Check if user has been saved for quick login.
  Future<bool> autoLoginRememberedUser() async {
    if (_myBox.get("persistent_data") == null) {
      createDefaultPersistentData();
    }
    Map<dynamic, dynamic> persisitent_data = _myBox.get("persistent_data");
    final savedEmail = persisitent_data["saved_email"];
    final savedPassword = persisitent_data["saved_password"];

    if (savedEmail != null && savedPassword != null) {
      return await login(email: savedEmail, password: savedPassword);
    } else {
      return false;
    }
  }

  /// Check if user has been saved. If so returns the email, otherwise the password.
  /// This is used to autofill the login screen.
  /// Returns `""` if no user has been saved.
  /// Returns the email if the email has been saved.
  String savedLoginEmail() {
    // Load from the box

    if (_myBox.get("persistent_data") == null) {
      createDefaultPersistentData();
    }

    Map<dynamic, dynamic> persisitent_data = _myBox.get("persistent_data");
    final savedEmail = persisitent_data["saved_email"];
    final savedPassword = persisitent_data["saved_password"];
    if (savedEmail != null && savedPassword != null) {
      return savedEmail;
    } else {
      return "";
    }
  }

  /// Login with report data
  ///
  /// If the login is successful, the user data will be updated.
  ///
  /// Returns `true` if the login is successful, `false` otherwise.
  bool handleLoginWithReportData(http.Response response) {
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      userData["player_id"] = responseData["player_id"];
      userData["name"] = responseData["user_name"];
      userData["user_id"] = responseData["user_id"];
      userData["current_competition"] = responseData["competition_id"];
      userData["competition_name"] = responseData["competition_name"];
      userData["cash"] = (responseData["user_cash"]?.toDouble()) ?? 0.0;
      userData["papel_asset_worth"] =
          (responseData["papel_asset_worth"]?.toDouble()) ?? 0.0;
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

    // Check if it was successfull
    if (response.statusCode == 200) {
      // Remember the user
      saveEmailPassword(email, password);
    }

    // Process the API response and return true/false
    return handleLoginWithReportData(response);
  }
}
