import 'package:paper_merchant/utils/color.dart';
import 'package:paper_merchant/utils/imagenames.dart';

const List notificationList = [
  {
    "img": stockUp,
    "title": "Axis Buy 2021.00 order is pending.",
    "time": "9.24 Am"
  },
  {
    "img": stockDown,
    "title": "Axis Sell 2125.50 order is pending.",
    "time": "10.00 pm"
  },
  {
    "img": stockUp,
    "title": "Eric Holfman2 hrs ago2 hrs ago",
    "time": "12.20 Am"
  },
  {
    "img": stockUp,
    "title": "Justas Galaburda5 hrs ago5 hrs ago",
    "time": "2.00 pm"
  },
  {
    "img": stockDown,
    "title": "Eric Holfman10 hrs ago10 hrs ago",
    "time": "3.00 Am"
  },
  {
    "img": stockDown,
    "title": "Charles Patterson12 hrs ago12 hrs ago",
    "time": "5.00 pm"
  },
];
const List drawerList = [
  {
    "img": homeIcon,
    "title": "Dashboard",
  },
  {
    "img": matualFund,
    "title": "Matual Funds",
  },
  {
    "img": research,
    "title": "Research",
  },
  {
    "img": bell,
    "title": "Price alert",
  },
  {
    "img": ipo,
    "title": "IPO",
  },
  {
    "img": calculator,
    "title": "Margin Calculator",
  },
  {
    "img": gold,
    "title": "Gold",
  },
  {
    "img": logOut,
    "title": "Sign out",
  },
];
const List bottomSheetListBuild = [
  {
    "img": rupee,
    "title": "NSE",
  },
  {
    "img": rupee,
    "title": "BSE",
  },
  {
    "img": arrow,
    "title": "Last Traded Prise",
  },
];
const List watchListPageBuildDesign = [];

const Map<String, Map<String, dynamic>> watchListPageBuildStocks = {
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

const List watchListPageBuildDesignMostStock = [
  {
    "img": arrowDownRight,
    "title": "RELIANCE",
    "subTitle": "NSE",
    "totalRs": "2510.20",
    "stock1": "+15.00",
    "stock2": "+1.00%",
    "color": green,
  },
  {
    "img": downIcon,
    "title": "CADILA",
    "subTitle": "NSE",
    "totalRs": "252.02",
    "stock1": "-45.10",
    "stock2": "-2.48%",
    "color": redEB5757,
  },
  {
    "img": arrowDownRight,
    "title": "HDFC BANK",
    "subTitle": "NSE",
    "totalRs": "2510.20",
    "stock1": "+15.65",
    "stock2": "+1.00%",
    "color": green,
  },
  {
    "img": arrowDownRight,
    "title": "ICICI BANK",
    "subTitle": "NSE",
    "totalRs": "451.20",
    "stock1": "+59.20",
    "stock2": "+2.50%",
    "color": green,
  },
  {
    "img": downIcon,
    "title": "TCS",
    "subTitle": "NSE",
    "totalRs": "1458.02",
    "stock1": "-35.10",
    "stock2": "-1.48%",
    "color": redEB5757,
  },
];
const List allStockScreenList = [];
const List executedListPageBuildDesign = [
  {
    "con1Color": redEB5757,
    "con1Text": "SELL",
    "bankName": "AXISBANK",
    "orderPrice": "2126",
    "con2Color": green219653,
    "con2Text": "COMPLETE",
    "ltp": "2126.20",
  },
  {
    "con1Color": appColor,
    "con1Text": "BUY",
    "bankName": "ICICIBANK",
    "orderPrice": "354",
    "con2Color": redEB5757,
    "con2Text": "REJECT",
    "ltp": "325.20",
  },
  {
    "con1Color": appColor,
    "con1Text": "BUY",
    "bankName": "AXISBANK",
    "orderPrice": "354",
    "con2Color": green219653,
    "con2Text": "COMPLETE",
    "ltp": "325.20",
  },
];
const List holdingListPageBuildDesign = [
  {
    "qty": "1",
    "bankName": "AXISBANK",
    "avgText": "2095.00",
    "profileText1": "+217.95",
    "profileText2": "+2.20%",
    "profileColor": green219653,
    "conText": "10200.00",
    "ltp": "2126.20",
  },
  {
    "qty": "10",
    "bankName": "CADILA",
    "avgText": "254.00",
    "profileText1": "-150.00",
    "profileText2": "+0.20%",
    "profileColor": redEB5757,
    "conText": "20000.00",
    "ltp": "250.20",
  },
];

const List<Map<String, dynamic>> UserPortfolioData = [
  {
    "count": 1,
    "price_average": 190.5,
    "id": "13340456-48e0-4075-8c68-b1be25bc315b",
    "updated_time": "2023-07-13T21:27:11.948837",
    "symbol": "AAPL",
    "player_id": "85b0ecf8-4ea7-4ad2-a388-30df41971095",
    "created_time": "2023-07-13T18:36:04.564303",
    "estimated_profit": 401
  },
  {
    "count": 1,
    "price_average": 320.3900146484375,
    "id": "89dd6fa9-c106-479f-9c11-12e2a2b8efbb",
    "updated_time": "2023-08-29T15:29:27.421439",
    "symbol": "ACN",
    "player_id": "85b0ecf8-4ea7-4ad2-a388-30df41971095",
    "created_time": "2023-08-29T15:29:27.421439",
    "estimated_profit": 0
  }
];

const List bookedListPageBuildDesign = [
  // {
  //   "qty": "01",
  //   "bankName": "AXISBANK",
  //   "avgText": "2095.00",
  //   "profileText1": "+217.95",
  //   "profileText2": "+2.20%",
  //   "profileColor": green219653,
  //   "ltp": "2126.20",
  // },
];
