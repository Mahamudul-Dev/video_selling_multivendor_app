import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../themes/app_colors.dart';

class GraphMonitor extends StatelessWidget {
  const GraphMonitor(
      {Key? key,
      required this.monitorTitle,
      required this.monitorSubTitle,
      required this.yAxisDataType,
      this.salesData,
      this.xAxisLabels})
      : super(key: key);

  final String monitorTitle;
  final String monitorSubTitle;
  final String yAxisDataType;
  final List<double>? salesData;
  final List<String>? xAxisLabels;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: LIGHT_ASH,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, left: 22, right: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  monitorTitle,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Colors.white),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Details',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$monitorSubTitle: ${salesData?.last}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            salesData != null && salesData!.isNotEmpty
                ? AspectRatio(
                    aspectRatio: 1.9,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: _buildXAxisTitles(),
                            leftTitles: SideTitles(showTitles: false),
                            topTitles: SideTitles(showTitles: false),
                            rightTitles: _buildRightTitles()),
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(
                            color: const Color(0xff37434d),
                            width: 1,
                          ),
                        ),
                        minX: 0,
                        maxX: salesData!.length.toDouble() - 1,
                        minY: 0,
                        maxY: salesData!.reduce((value, element) =>
                                value > element ? value : element) +
                            100,
                        lineBarsData: [
                          LineChartBarData(
                            spots: List.generate(
                              salesData?.length ?? 0,
                              (index) => FlSpot(
                                  index.toDouble(), salesData?[index] ?? 0.0),
                            ),
                            isCurved: true,
                            colors: [TEAL, GREEN_TEAL],
                            barWidth: 4,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(show: true, colors: [
                              TEAL.withOpacity(0.3),
                              GREEN_TEAL.withOpacity(0.3)
                            ]),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      'No sales data available.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  SideTitles _buildRightTitles() {
    // Generate labels dynamically
    List<String> labels = [];

    if (salesData != null) {
      if (salesData!.isNotEmpty) {
        // Calculate a reasonable step size based on the range of sales data
        double minSale = salesData!
            .reduce((value, element) => value < element ? value : element);
        double maxSale = salesData!
            .reduce((value, element) => value > element ? value : element);
        double range = maxSale - minSale;
        double stepSize =
            range / 5; // You can adjust this value based on your preference

        // Generate labels dynamically using the stepSize
        for (double i = minSale; i <= maxSale + stepSize / 2; i += stepSize) {
          labels.add(i.toStringAsFixed(1)); // Adjust precision as needed
        }
      }
    }

    return SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: Colors.grey, fontSize: 5),
      getTitles: (value) {
        Logger().i({'Right Side Value': value});
        // if (labels.isNotEmpty && value >= 0 && value < labels.length) {
        //   return value.toString();
        // }
        return yAxisDataType == 'dollar' ? '\$$value' : '$value';
      },
    );
  }

  SideTitles _buildXAxisTitles() {
    return SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
      getTitles: (value) {
        Logger().i({'Bottom Side Value': value});
        if (xAxisLabels != null && value >= 0 && value < xAxisLabels!.length) {
          return xAxisLabels![value.toInt()];
        }
        return '';
      },
    );
  }
}
