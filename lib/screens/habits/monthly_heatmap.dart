import 'package:flutter/material.dart';

import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:side_track/hive/utils.dart';

class MonthlyHeatMap extends StatelessWidget {
  const MonthlyHeatMap(
      {super.key, required this.dataSets, required this.startDate});

  final Map<DateTime, int>? dataSets;
  final String startDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObj(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        defaultColor: Theme.of(context).colorScheme.primary,
        colorMode: ColorMode.color,
        textColor: Theme.of(context).colorScheme.primary,
        datasets: dataSets,
        scrollable: true,
        size: 30,
        showText: true,
        showColorTip: false,
        colorsets: const {
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(150, 2, 179, 8),
          8: Color.fromARGB(180, 2, 179, 8),
          9: Color.fromARGB(200, 2, 179, 8),
          10: Color.fromARGB(220, 2, 179, 8),
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
