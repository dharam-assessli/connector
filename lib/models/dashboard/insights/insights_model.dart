// ignore_for_file: lines_longer_than_80_chars

class InsightsModel {
  InsightsModel({required this.value, required this.label});

  final num value;
  final String label;
}

final List<InsightsModel> insightsData = List<InsightsModel>.generate(10, (
  int index,
) {
  return InsightsModel(
    value: (index + 1) * 10000,
    label: "Lorem ipsum dolor sit amet ${index + 1}",
  );
});
