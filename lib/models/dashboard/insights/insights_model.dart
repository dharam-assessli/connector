import "dart:math";

import "package:horizon/utils/timeago_util.dart";

class InsightsModel {
  InsightsModel({required this.value, required this.label});

  final num value;
  final String label;
}

final List<InsightsModel> insightsData = List<InsightsModel>.generate(10, (
  int index,
) {
  return InsightsModel(
    value: Random().nextInt(10000) + 1000,
    label: TimeagoUtil().timeAgo(
      DateTime.now().subtract(Duration(days: index + 1)),
    ),
  );
});
