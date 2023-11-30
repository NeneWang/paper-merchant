## Links

Diagram Process

https://app.diagrams.net/?libs=general;flowchart#G1dBLbwRWmtB2V1uJhricZBCyXAEZr1rLU


## Deployment

```
flutter buiid
firebase deploy
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

```

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





