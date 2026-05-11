import "package:connector/functions/onboarding/weight_functions.dart";
import "package:connector/utils/languages_util.dart";
import "package:flutter/cupertino.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class WeightPicker extends StatelessWidget {
  const WeightPicker({
    required this.isWeightInKg,
    required this.weightInKg,
    required this.weightInLb,
    required this.onWeightChangedKg,
    required this.onWeightChangedLb,
    super.key,
  });

  final bool isWeightInKg;
  final int weightInKg;
  final int weightInLb;
  final void Function(int value) onWeightChangedKg;
  final void Function(int value) onWeightChangedLb;

  @override
  Widget build(BuildContext context) {
    return isWeightInKg
        ? CupertinoPicker(
            key: const Key("kg"),
            itemExtent: 40,
            scrollController: FixedExtentScrollController(
              initialItem: weightInKg - minKg,
            ),
            onSelectedItemChanged: (int index) {
              onWeightChangedKg(kgList[index]);
            },
            changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
            children: List<Widget>.generate(kgList.length, textWidget),
          )
        : CupertinoPicker(
            key: const Key("lb"),
            itemExtent: 40,
            scrollController: FixedExtentScrollController(
              initialItem: weightInLb - minLb,
            ),
            onSelectedItemChanged: (int index) {
              onWeightChangedLb(lbList[index]);
            },
            changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
            children: List<Widget>.generate(lbList.length, textWidget),
          );
  }

  Widget textWidget(int index) {
    final dynamic item = isWeightInKg ? kgList[index] : lbList[index];

    final String kg = LanguagesUtil().weightUnitKg;
    final String lb = LanguagesUtil().weightUnitLb;

    return CustomText(
      data: "$item ${isWeightInKg ? kg : lb}",
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
