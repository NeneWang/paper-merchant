import 'package:mymoney/data/utils.dart';
import 'package:mymoney/utils/utils_text.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';

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

    userAsset = [
      {
        "player_id": "85b0ecf8-4ea7-4ad2-a388-30df41971095",
        "symbol": "AAPL",
        "count": 1,
        "created_time": "2023-07-13T18:36:04.564303",
        "estimated_profit": 401,
        "id": "13340456-48e0-4075-8c68-b1be25bc315b",
        "price_average": 190.5,
        "updated_time": "2023-07-13T21:27:11.948837"
      },
      {
        "player_id": "85b0ecf8-4ea7-4ad2-a388-30df41971095",
        "symbol": "ACN",
        "count": 1,
        "created_time": "2023-08-29T15:29:27.421439",
        "estimated_profit": 0,
        "id": "89dd6fa9-c106-479f-9c11-12e2a2b8efbb",
        "price_average": 320.3900146484375,
        "updated_time": "2023-08-29T15:29:27.421439"
      }
    ];

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

  void syncData() async {
    final playerId = userData["player_id"];
    if (playerId != null) {
      final assetsUrl =
          "$backendAPI/api/assets/$playerId"; // Replace with actual API URL

      // Make API call using your preferred HTTP client (e.g., http package)
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
