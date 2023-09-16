import 'package:mymoney/data/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';

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
  List<Map<dynamic, dynamic>> userAsset = [];

  // For quick reference
  Map<dynamic, dynamic> userStockPrices = {};
  Map<dynamic, dynamic> userBookmarkPrices = {};
  List<String> ticketNames = [];
  Map<dynamic, dynamic> showStockData =
      {}; //The stocks being shown in the watchlist

  void createDefaultData() {
    userData = {
      "name": generateShortGuid(5),
      "user_id": "4379afa2-8dd0-471d-8d1e-695106dae29a",
      "is_connected": "false",
      "current_competition": "7bc69deb-b1b4-4d45-aab1-43ce2d9caf8b",
      "player_id": "85b0ecf8-4ea7-4ad2-a388-30df41971095",
      "cash": 1000000.00,
      "papel_asset_worth": 507.57000732421875
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

    userAsset = [];

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

  void loadData() {
    // If userData doesnt exist then create it
    if (_myBox.get("userData") == null) {
      createDefaultData();
    }

    if ((_myBox.get("userAsset") == null || _myBox.get("userAsset").isEmpty) ||
        (_myBox.get("userBookmarkPrices") == null ||
            _myBox.get("userBookmarkPrices").isEmpty) ||
        (_myBox.get("userStockPrices") == null ||
            _myBox.get("userStockPrices").isEmpty)) {
      _myBox.put("userAsset", userAsset);
      syncData();
    }

    if (_myBox.get("ticketNames") == null ||
        _myBox.get("ticketNames").isEmpty) {
      getStockNames();
    } else {
      ticketNames = _myBox.get("ticketNames");
    }

    userData = _myBox.get("userData");
    List<dynamic> userAssetData = _myBox.get("userAsset");
    userAsset = [];
    for (var asset in userAssetData) {
      if (asset is Map<String, dynamic>) {
        userAsset.add(asset);
      }
    }

    userBookmarkPrices = _myBox.get("userBookmarkPrices");
    userStockPrices = _myBox.get("userStockPrices");
  }

  Map<dynamic, dynamic> getUserAsset(String userAssetSymbol) {
    for (var asset in userAsset) {
      if (asset["symbol"] == userAssetSymbol) {
        return asset;
      }
    }
    return {};
  }

  int updateUserAssetCount(String userAssetSymbol, int increaseBy) {
    for (var asset in userAsset) {
      if (asset["symbol"] == userAssetSymbol) {
        if (asset["count"] + increaseBy < 0) {
          return asset["count"] - increaseBy;
        }
        asset["count"] += increaseBy;
        return asset["count"];
      }
    }
    return 0;
  }

  Future<Map<String, dynamic>> getDetailsShare(
      String symbol, String price) async {
    print("getDetails store");

    try {
      loadData();

      final test_if_data_exists = getUserAsset(symbol);
      if (!test_if_data_exists.containsKey("count")) {
        await syncData();
      }

      final userAssetData = getUserAsset(symbol);

      final double currentSymbolPrice = double.parse(price);

      final int count = userAssetData["count"];
      final double averagePrice = userAssetData["price_average"];
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
      print(res);
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
        "user_cash": "",
      };
      return res;
    }
  }

  Future<List<Map<String, dynamic>>> getShowStockAsList() async {
    if (showStockData.isEmpty) {
      await populateAllStocksScreenData();
    }
    return convertToListingFormat(showStockData);
  }

  Future populateAllStocksScreenData() async {
    // get the top 10 stocks from ticket names and request api to include their data on them.

    if (_myBox.get("ticketNames") == null ||
        _myBox.get("ticketNames").isEmpty) {
      await getStockNames();
    } else {
      ticketNames = _myBox.get("ticketNames");
    }
    print("checking the first 10 out of " + ticketNames.length.toString());
    final stocksToLookup = ticketNames.sublist(0, 10);
    print("Researching multiple:");
    print(stocksToLookup);
    showStockData = await researchMultiple(stocksToLookup);
    return;
  }

  Future<void> purchaseStock(String ticker_symbol,
      {int count = 1, double price = 100}) async {
    // Create post request of model:
    // class AssetPurchase(BaseModel):
    // player_id: str
    // symbol: str
    // count: int
    // price: float
    // Into api: "${backendAPI}/api/buy";
    final POST_URL = "${backendAPI}/api/buy";
    print("Purchase stock requested");
    print(POST_URL);

    // update userCash
    if (!(price * count > userData["cash"])) {
      userData["cash"] -= price * count;
      updateUserAssetCount(ticker_symbol, count);

      // Update the stock names
      if (!ticketNames.contains(ticker_symbol)) {
        ticketNames.add(ticker_symbol);
        _myBox.put("ticketNames", ticketNames);
      }
    }

    final response = await http.post(
      Uri.parse(POST_URL),
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
      print("Purchase stock success");
      print(response.body);
      await syncData();
      return;
    } else {
      // print("Purchase stock failed");
      print(response.body);
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

    final countStocks = updateUserAssetCount(ticker_symbol, -count);
    // update userCash
    if (countStocks >= 0) {
      userData["cash"] += price * count;

      // Update the stock names
      if (countStocks == 0) {
        ticketNames.remove(ticker_symbol);
        _myBox.put("ticketNames", ticketNames);
      }
    }

    final POST_URL = "${backendAPI}/api/sell";
    print("Sell stock requested");
    print(POST_URL);

    final response = await http.post(
      Uri.parse(POST_URL),
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
      print("Sell stock success");
      print(response.body);
      await syncData();
      return;
    } else {
      // print("Purchase stock failed");
      print(response.body);
      return;
    }
  }

  Future<Map<dynamic, dynamic>> researchMultiple(
      List<String> stocksNames) async {
    final multipleAPI = "${backendAPI}/api/get_today_data_multiple";
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
      return {};
    }
  }

  Future getStockNames() async {
    final stockAPI = "$backendAPI/api/stickers"; // Replace with actual API URL
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
      print("Failed to fetch stock names");
      return;
    }
  }

  Future syncData() async {
    final playerId = userData["player_id"];
    if (playerId != null) {
      final assetsUrl =
          "$backendAPI/api/assets/$playerId"; // Replace with actual API URL

      // Make API call using your pr eferred HTTP client (e.g., http package)
      // Example using http package:
      final response = await http.get(Uri.parse(assetsUrl));

      // Process the API response and print assets
      if (response.statusCode == 200) {
        final assetsData = json.decode(response.body);
        userAsset = []; //Empty the userData before
        for (var asset in assetsData) {
          if (asset is Map<String, dynamic>) {
            userAsset.add(asset);
          }
        }
      } else {
        print("Failed to fetch assets");
      }

      _myBox.put("userAsset", userAsset);

      const getHighlightURL =
          "$backendAPI/api/get_highlight_today"; // Replace with actual API URL

      final bookmarks = ["META", "AAPL"];
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
        print("body 2");
        print(responseData);
        userBookmarkPrices = responseData["bookmarks"];
        userStockPrices = responseData["stocks"];
        userData["papel_asset_worth"] = responseData["papel_asset_worth"];
        userData["cash"] = responseData["user_cash"];

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
    }
  }
}
