// ignore_for_file: avoid_redundant_argument_values

import "package:connector/constants/colors_constants.dart";
import "package:connector/models/dashboard/chart/finance_model.dart";
import "package:fl_chart/fl_chart.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class FinanceBarChart extends StatelessWidget {
  const FinanceBarChart({required this.rxBars, super.key});
  final RxList<FinanceBar> rxBars;

  static const Duration animDuration = Duration(seconds: 1);
  static const Curve animCurve = Curves.easeOutCubic;

  static const double barWidth = 32;

  static const double minBarSlot = 56; // bar + gap; if narrower, we scroll

  static Color barColor = ColorsConstants().green;

  List<BarChartGroupData> toBarGroups(List<FinanceBar> list, Color color) {
    return List<BarChartGroupData>.generate(list.length, (int i) {
      return BarChartGroupData(
        x: i,
        barRods: <BarChartRodData>[
          BarChartRodData(
            toY: list[i].value,
            width: barWidth,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            gradient: LinearGradient(
              colors: <Color>[
                color.withValues(alpha: 1.00),
                color.withValues(alpha: 0.24),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }

  ({double minY, double maxY}) computeYRange(List<FinanceBar> list) {
    if (list.isEmpty) {
      return (minY: 0, maxY: 100);
    }

    final List<double> allValues = list.map((FinanceBar b) {
      return b.value;
    }).toList();

    final double rawMax = allValues.reduce((double a, double b) {
      return a > b ? a : b;
    });

    final double maxY = (rawMax * 1.2).ceilToDouble();

    return (minY: 0, maxY: maxY);
  }

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      final List<FinanceBar> data = rxBars.toList();

      if (data.isEmpty) {
        return const Center(
          child: CustomText(
            data: "No data",
            style: TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }

      final List<BarChartGroupData> barGroups = toBarGroups(data, barColor);
      final ({double maxY, double minY}) yRange = computeYRange(data);

      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          final double naturalWidth = data.length * minBarSlot;

          // If bars fit the available space, fill it. Otherwise, scroll.
          final bool shouldScroll = naturalWidth > availableWidth;
          final double chartWidth = shouldScroll
              ? naturalWidth
              : availableWidth;

          final Widget chart = SizedBox(
            width: chartWidth,
            child: chartWidget(
              context,
              barGroups: barGroups,
              data: data,
              minY: yRange.minY,
              maxY: yRange.maxY,
            ),
          );

          if (!shouldScroll) {
            return chart;
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: chart,
          );
        },
      );
    });
  }

  Widget chartWidget(
    final BuildContext context, {
    required List<BarChartGroupData> barGroups,
    required List<FinanceBar> data,
    required double minY,
    required double maxY,
  }) {
    return BarChart(
      key: UniqueKey(),
      duration: animDuration,
      curve: animCurve,
      BarChartData(
        minY: minY,
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false, border: const Border()),
        barTouchData: const BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (double value, TitleMeta meta) {
                final int index = data.indexWhere(
                  (FinanceBar b) => b.value == value,
                );

                if (index == -1) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: CustomText(
                    data: "${data[index].value.toInt()}%",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false, reservedSize: 0),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (double value, TitleMeta meta) {
                final int index = value.toInt();

                if (index < 0 || index >= data.length) {
                  return const SizedBox();
                }

                return SideTitleWidget(
                  space: 4,
                  meta: meta,
                  child: CustomText(
                    data: data[index].label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: barGroups,
      ),
    );
  }
}
