## Links

Diagram Process

https://app.diagrams.net/?libs=general;flowchart#G1dBLbwRWmtB2V1uJhricZBCyXAEZr1rLU

## Disbaling XML Errors

```
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

However it seems that the error dissapears when you remove the `/` at the end.

Lesson:
- it seems that the way you direct in Fastapi the endpoint (with or without `/`) is important.




## Deployment

Deployment for the web is done by running the following commands:

```
flutter build web
firebase deploy
```

It will be posted at:

Running in chroe

```
flutter config --enable-web
flutter run -d chrome

```


## Logs


```
{
  "bookmarks_names": [
    "AAPL",
    "JPM",
    "MSFT"
  ],
  "bookmarks": {
    "AAPL": {
      "Date": "2023-11-30",
      "Open": 190.9,
      "High": 192.09,
      "Low": 188.97,
      "Close": 189.37,
      "Volume": 43013232
    },
    "JPM": {
      "Date": "2023-11-30",
      "Open": 154.17,
      "High": 155.625,
      "Low": 154,
      "Close": 154.32,
      "Volume": 9126055
    },
    "MSFT": {
      "Date": "2023-11-30",
      "Open": 383.76,
      "High": 384.3,
      "Low": 377.44,
      "Close": 378.85,
      "Volume": 28963577
    }
  },
  "stocks": {
    "JPM": {
      "Date": "2023-11-30",
      "Open": 154.17,
      "High": 155.625,
      "Low": 154,
      "Close": 154.32,
      "Volume": 9126055
    },
    "MSFT": {
      "Date": "2023-11-30",
      "Open": 383.76,
      "High": 384.3,
      "Low": 377.44,
      "Close": 378.85,
      "Volume": 28963577
    },
    "AAPL": {
      "Date": "2023-11-30",
      "Open": 190.9,
      "High": 192.09,
      "Low": 188.97,
      "Close": 189.37,
      "Volume": 43013232
    },
    "COIN": {
      "Date": "2023-11-30",
      "Open": 127.82,
      "High": 131.42,
      "Low": 126.3,
      "Close": 127.82,
      "Volume": 13908770
    }
  },
  "papel_asset_worth": 1004.6800000000001,
  "user_cash": 9110.24,
  "user_total_worth": 10114.92,
  "player_id": "92cb1815-bbc7-47aa-aba4-4788425b0524",
  "competition_id": "7bc69deb-b1b4-4d45-aab1-43ce2d9caf8b",
  "user_id": "bbf8e248-ca89-41c4-b55c-e4e20977a6e0",
  "user_name": "Nelson the Tester",
  "user_email": "wangnelson4@gmail.com"
}
```

### Adding Images

- [ ] SO knowing this si how you add an image

```dart
Image(
    image: AssetImage("assets/image/home/AXISBANK.png"),
),
```



Great this works:

```dart
Image.network(
"https://api.polygon.io/v1/reference/company-branding/d3d3LmpwbW9yZ2FuY2hhc2UuY29t/images/2023-05-01_icon.jpeg?apiKey=JzpLmiKOusmtMSoeIQxAjhdeU8aPS5QO",
),
```
Lets make it better to work:

Lets store the API key? or should that be provided together with the request itself?

You can see here that there is no strucutre for the stock, which means that the modification is harmless

```dart
List<Map<String, dynamic>> convertToListingFormat(
    Map<dynamic, dynamic> inputMap) {
  List<Map<String, dynamic>> outputList = [];

  inputMap.forEach((key, value) {
    double adjClose = value["Adj Close"] ?? 0.0;
    String imageUrl = value['icon_url'] ?? "";
    outputList.add({
      "title": key,
      "imageUrl": imageUrl,
      "totalRs": adjClose
          .toStringAsFixed(2), // Format the double with 2 decimal places
    });
  });
}
```

### Adding more information to the indvidual screen

```dart
Divider(
    thickness: 3,
    color: grayF2F2F2,
),
FutureBuilder(
    future: db.getDetailsShare(widget.ticker, widget.price),
```


```dart

simpleStockListViewItem(
title: snapshot.data![index]["title"],
total: snapshot.data![index]["totalRs"],
imageUrl: snapshot.data![index]["imageUrl"],
)
```

This is the widget price:

```dart
const Text("Current Price"),
Text(widget.price, style: blackBoldStyle)
```

Where do I get to use add the price value on it? Can I embed the entire data into the screen?


```dart
final String ticker;
final String price;

const BuySellScreen({super.key, required this.ticker, required this.price});
```


- Is not being called on watchlist_screen, so it has to be on the Simple List Component


```dart title = "simpleListItemDesign"

simpleStockListViewItem(
    /**
      * Basic design with a random chart, and price.
    */
    {
  String? title,
  String? total,
  BuildContext? context,
  String? imageUrl,
  colorName = "black",
}) {
  return InkWell(
    onTap: () {
      Get.to(BuySellScreen(ticker: title, price: total));
```

```dart

buyMenuData({symbol, price, color1, quantityController, userCash = ""}) {
  return Padding(
  )}
```

Lets check the user cash?

Building the History

Lets call the api that should be here. Lets see how the future builder works on this case:

```dart

FutureBuilder(
    future: db.getDetailsShare(widget.ticker, widget.price),
    builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
        userCash = snapshot.data!["user_cash"];
       .... }})
```



Here the details share that is beign called on future. We can see that is async and returns a json once it finishes. However, we can set so that it calls EVERY time to reviw the transactions of this specific stock. Unless we believe that the user want sto check on and is something that we want to see every time we load the stock data. Considering that is actually not much data, perphaps is a good idea to get and append that from the stock perspective?.


```dart

  Future<Map<String, dynamic>> getDetailsShare(
      String symbol, String price) async {
    print("getDetails store");

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

```

- [ ] Improve the general portfolio to get that sare and resume price.
- [ ] Detect which is the API to modify
- [ ] 


We know that the data being searched is this one:

```
userPortfolio
```

given

```dart

  Map<dynamic, dynamic> getuserPortfolio(String userPortfolioSymbol) {
    for (var asset in userPortfolio) {
      if (asset["symbol"] == userPortfolioSymbol) {
        return asset;
      }
    }
    return {};
  }

```


Found it

```dart

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
      }
```


The api to modify is `api/assets`

r
Ideas of why after ===> connection state t prints null, even if on

Get TickerTransation I can see that is printing the body of:
 [{player_id: 92cb1815-bbc7-47aa-aba4-4788425b0524, symbol: EBAY, transaction_type: BUY, total_price: 81.28, updated_time: 2023-11-30T18:58:03.099814, count: 2, id: 88c442fb-9803-4c6f-bde9-40cfae575339, price: 40.64, created_time: 2023-11-30T18:58:03.099814}, {player_id: 92cb1815-bbc7-47aa-aba4-4788425b0524, symbol: EBAY, transaction_type: SELL, total_price: 43.91, updated_time: 2023-09-18T21:18:09.102293, count: 1, id: 00be748a-d8e6-4fec-a0eb-93e85d17d8d5, price: 43.91, created_time: 2023-09-18T21:18:09.102293}, {player_id: 92cb1815-bbc7-47aa-aba4-4788425b0524, symbol: EBAY, transaction_type: BUY, total_price: 43.91, updated_time: 2023-09-18T21:16:03.748705, count: 1, id: 4ab49911-45ce-4574-b372-3e62fd56213a, price: 43.91, created_time: 2023-09-18T21:16:03.748705}]


This is how to fetch the apis correctly

```dart

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

```

For example we can run this by: "7bc69deb-b1b4-4d45-aab1-43ce2d9caf8b"

/api/competitors/7bc69deb-b1b4-4d45-aab1-43ce2d9caf8b


Adding Readme

```
fvm flutter pub add charts_flutter_new

fvm flutter pub add charts_flutter
```


### Publishing to the Play Store


```
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload


dar***
```


```
storePassword=<password-from-previous-step>
keyPassword=<password-from-previous-step>
keyAlias=upload
storeFile=<keystore-file-location>

```

```
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
      ...
}

```


Adding buildTypes:


```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }

```


```
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}

```


```
applicationId "com..anvildev.papermerchant"
```


```
flutter build appbundle
```



### Craft API for #2 History

1. [ ] Fetch all the transactions given a user and a stock.
2. [ ] Fetch all the transactions given a user 



