import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';

/**
 * Filter the ticket symbols based on their similarity to the input
 * @param input The input string to filter the tickets by
 * @param ticketList The list of tickets to filter
 * @returns The filtered list of tickets
 */
List<String> filterTickets(String input, List<String> ticketList) {
  // Convert input to lowercase for case-insensitive comparison
  final normalizedInput = input.toLowerCase();

  // Filter the ticket symbols based on their similarity to the input
  final filteredTickets = ticketList.where((ticket) {
    final normalizedTicket = ticket.toLowerCase();
    return normalizedTicket.startsWith(normalizedInput);
  }).toList();

  return filteredTickets;
}

// ignore: slash_for_doc_comments
/**
     * Convert the input map to a list of maps with the following format:
     *  {A: {Adj Close: 122.68000030517578, Close: 122.68000030517578, High: 122.94000244140625, Low: 121.62999725341797, Open: 122.33999633789062, Volume: 1157900}...}
     * into:
     * [{title: A, totalRs: 122.68}, {title: AA, totalRs: 22.68}, ...]
     */
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
      "stockData": value,
    });
  });

  return outputList;
}

double getRandomPointY() {
  return Random().nextInt(6).toDouble();
}

final List<Color> gradientColors = [
  const Color(0xff73BE8C),
  const Color(0xff73BE8C),
];

LineChartBarData getRandomLineChartData() {
  return LineChartBarData(
    spots: [
      FlSpot(0, getRandomPointY()),
      FlSpot(2.6, getRandomPointY()),
      FlSpot(4.9, getRandomPointY()),
      FlSpot(6.8, getRandomPointY()),
      FlSpot(8, getRandomPointY()),
      FlSpot(9.5, getRandomPointY()),
      FlSpot(11, getRandomPointY()),
    ],
    isCurved: true,
    colors: gradientColors,
    barWidth: 2,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      colors: [
        const Color(0xff73BE8C).withOpacity(0.4),
        const Color(0xf73BE8C),
      ],
    ),
  );
}
