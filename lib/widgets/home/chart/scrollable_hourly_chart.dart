// ignore_for_file: avoid_redundant_argument_values

import "dart:math";

import "package:connector/constants/colors_constants.dart";
import "package:connector/models/dashboard/chart/chart_model.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class ScrollableHourlyChart extends StatelessWidget {
  const ScrollableHourlyChart({required this.rxChartData, super.key});
  final Rx<ChartModel> rxChartData;

  List<FlSpot> toSpots(List<Predicted>? list) {
    return list != null
        ? List<FlSpot>.generate(list.length, (int i) {
            return FlSpot(i.toDouble(), list[i].value ?? 0);
          })
        : const <FlSpot>[];
  }

  static const Duration animDuration = Duration(seconds: 1);
  static const Curve animCurve = Curves.easeOutCubic;

  static Color predictedColor = ColorsConstants().blue;

  static Color generatedColor = ColorsConstants().green;

  ({double minY, double maxY, double interval}) computeYRange(
    List<FlSpot> predicted,
    List<FlSpot> generated,
  ) {
    final List<double> allValues = <double>[
      ...predicted.map((FlSpot s) => s.y),
      ...generated.map((FlSpot s) => s.y),
    ];

    if (allValues.isEmpty) {
      return (minY: 0, maxY: 100, interval: 10);
    }

    final double rawMin = allValues.reduce(
      (double a, double b) => a < b ? a : b,
    );

    final double rawMax = allValues.reduce(
      (double a, double b) => a > b ? a : b,
    );

    final double padding = (rawMax - rawMin) * 0.1;
    final double paddedMin = rawMin - padding;
    final double paddedMax = rawMax + padding;

    final double range = paddedMax - paddedMin;

    final double interval = _niceInterval(range / 5);

    final double minY = (paddedMin / interval).floor() * interval;

    final double maxY = (paddedMax / interval).ceil() * interval;

    return (minY: minY, maxY: maxY, interval: interval);
  }

  double _niceInterval(double raw) {
    if (raw == 0) {
      return 1.0;
    }

    final double magnitude = pow(
      10,
      (log(raw) / ln10).floor().toDouble(),
    ).toDouble();
    final double fraction = raw / magnitude;

    final double nice;
    if (fraction < 1.5) {
      nice = 1;
    } else if (fraction < 3.5) {
      nice = 2;
    } else if (fraction < 7.5) {
      nice = 5;
    } else {
      nice = 10;
    }

    return nice * magnitude;
  }

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      final List<FlSpot> predictedSpots = toSpots(rxChartData.value.predicted);
      final List<FlSpot> generatedSpots = toSpots(rxChartData.value.generated);

      final List<Predicted> times =
          rxChartData.value.predicted ??
          rxChartData.value.generated ??
          const <Predicted>[];

      if (times.isEmpty) {
        return const Center(
          child: CustomText(
            data: "No data",
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }

      final double chartWidth = times.length * kToolbarHeight;

      final ({double interval, double maxY, double minY}) yRange =
          computeYRange(predictedSpots, generatedSpots);

      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: kToolbarHeight - 16,
              child: yAxisChart(
                context,
                predictedSpots: predictedSpots,
                generatedSpots: generatedSpots,
                times: times,
                minY: yRange.minY,
                maxY: yRange.maxY,
                interval: yRange.interval,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: chartWidth,
                  child: xAxisChart(
                    context,
                    predictedSpots: predictedSpots,
                    generatedSpots: generatedSpots,
                    times: times,
                    minY: yRange.minY,
                    maxY: yRange.maxY,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget yAxisChart(
    final BuildContext context, {
    required List<FlSpot> predictedSpots,
    required List<FlSpot> generatedSpots,
    required List<Predicted> times,
    required double minY,
    required double maxY,
    required double interval,
  }) {
    return LineChart(
      key: UniqueKey(),
      chartRendererKey: UniqueKey(),
      duration: animDuration,
      curve: animCurve,
      transformationConfig: const FlTransformationConfig(
        scaleAxis: FlScaleAxis.vertical,
      ),
      LineChartData(
        minY: minY,
        maxY: maxY,
        clipData: const FlClipData.all(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false, border: const Border()),
        lineTouchData: const LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 16),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 16 * 2.08,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                return const SizedBox();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 16 * 2.08,
              interval: interval,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  space: 0,
                  meta: meta,
                  child: CustomText(
                    data: value.toInt().toString(),
                    style: const TextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: const <LineChartBarData>[],
      ),
    );
  }

  Widget xAxisChart(
    final BuildContext context, {
    required List<FlSpot> predictedSpots,
    required List<FlSpot> generatedSpots,
    required List<Predicted> times,
    required double minY,
    required double maxY,
  }) {
    return LineChart(
      key: UniqueKey(),
      chartRendererKey: UniqueKey(),
      duration: animDuration,
      curve: animCurve,
      transformationConfig: const FlTransformationConfig(
        scaleAxis: FlScaleAxis.horizontal,
      ),
      LineChartData(
        minX: 0,
        maxX: (times.length - 1).toDouble(),
        minY: minY,
        maxY: maxY,
        clipData: const FlClipData.all(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false, border: const Border()),
        lineTouchData: const LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 16),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 16 * 2.08,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  space: 0,
                  meta: meta,
                  child: CustomText(
                    data: times[value.toInt()].time ?? "",
                    style: const TextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0),
          ),
        ),
        lineBarsData: <LineChartBarData>[
          LineChartBarData(
            spots: predictedSpots,
            isCurved: true,
            curveSmoothness: 0.56,
            color: predictedColor,
            barWidth: 2.56,
            dashArray: const <int>[6, 4],
            dotData: FlDotData(
              show: true,
              getDotPainter:
                  (
                    FlSpot spot,
                    double xPercentage,
                    LineChartBarData barData,
                    int index, {
                    double? size,
                  }) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: ColorsConstants().white,
                      strokeWidth: 2,
                      strokeColor: predictedColor,
                    );
                  },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: <Color>[
                  predictedColor.withValues(alpha: 0.56),
                  predictedColor.withValues(alpha: 0.00),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          LineChartBarData(
            spots: generatedSpots,
            isCurved: true,
            curveSmoothness: 0.56,
            color: generatedColor,
            barWidth: 2.56,
            dashArray: const <int>[6, 4],
            dotData: FlDotData(
              show: true,
              getDotPainter:
                  (
                    FlSpot spot,
                    double xPercentage,
                    LineChartBarData barData,
                    int index, {
                    double? size,
                  }) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: ColorsConstants().white,
                      strokeWidth: 2,
                      strokeColor: generatedColor,
                    );
                  },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: <Color>[
                  generatedColor.withValues(alpha: 0.56),
                  generatedColor.withValues(alpha: 0.00),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
