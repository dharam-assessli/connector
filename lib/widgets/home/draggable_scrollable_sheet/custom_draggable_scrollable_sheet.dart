import "package:connector/functions/mood_functions.dart";
import "package:connector/models/dashboard/insights/insights_model.dart";
import "package:connector/models/dashboard/quick_start/quick_start_model.dart";
import "package:connector/widgets/home/draggable_scrollable_sheet/insights_widget.dart";
import "package:connector/widgets/home/draggable_scrollable_sheet/mood_widget.dart";
import "package:connector/widgets/home/draggable_scrollable_sheet/quick_start_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/containers/custom_card.dart";

class CustomDraggableScrollableSheet extends StatelessWidget {
  const CustomDraggableScrollableSheet({
    required this.rxMood,
    required this.rxSelectedMoodIndex,
    required this.onMoodChanged,
    required this.rxQuickStart,
    required this.rxSelectedQuickStartIndex,
    required this.onQuickStartChanged,
    required this.rxInsights,
    super.key,
  });

  final Rx<Mood> rxMood;
  final Rx<num> rxSelectedMoodIndex;
  final Future<void> Function(num value) onMoodChanged;
  final RxList<QuickStartModelOuter> rxQuickStart;
  final Rx<num> rxSelectedQuickStartIndex;
  final Future<void> Function(num value) onQuickStartChanged;
  final RxList<InsightsModel> rxInsights;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      minChildSize: 0.048,
      initialChildSize: 0.048,
      builder: (BuildContext context, ScrollController scrollController) {
        return CustomCard(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      handleWidget(context),
                      const SizedBox(height: 16.0),
                      MoodWidget(
                        rxMood: rxMood,
                        rxSelectedMoodIndex: rxSelectedMoodIndex,
                        onMoodChanged: onMoodChanged,
                      ),
                      const SizedBox(height: 16.0),
                      QuickStartWidget(
                        rxQuickStart: rxQuickStart,
                        rxSelectedQuickStartIndex: rxSelectedQuickStartIndex,
                        onQuickStartChanged: onQuickStartChanged,
                      ),
                      const SizedBox(height: 16.0),
                      InsightsWidget(rxInsights: rxInsights),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget handleWidget(BuildContext context) {
    return Container(
      height: 4,
      width: kToolbarHeight * 2,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium?.color,
        borderRadius: BorderRadius.circular(360),
      ),
      child: const SizedBox(),
    );
  }
}
