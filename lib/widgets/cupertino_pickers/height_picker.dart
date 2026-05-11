import "package:connector/functions/onboarding/height_functions.dart";
import "package:connector/utils/languages_util.dart";
import "package:flutter/cupertino.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class HeightPicker extends StatelessWidget {
  const HeightPicker({
    required this.isHeightInFt,
    required this.heightInFt,
    required this.heightInCm,
    required this.onHeightChangedFt,
    required this.onHeightChangedCm,
    super.key,
  });

  final bool isHeightInFt;
  final (int, int) heightInFt;
  final int heightInCm;
  final void Function((int, int) value) onHeightChangedFt;
  final void Function(int value) onHeightChangedCm;

  @override
  Widget build(BuildContext context) {
    return isHeightInFt
        ? CupertinoPicker(
            key: const Key("ft"),
            itemExtent: 40,
            scrollController: FixedExtentScrollController(
              initialItem: ftList.indexWhere(((int, int) e) => e == heightInFt),
            ),
            onSelectedItemChanged: (int index) {
              onHeightChangedFt(ftList[index]);
            },
            changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
            children: List<Widget>.generate(ftList.length, textWidget),
          )
        : CupertinoPicker(
            key: const Key("cm"),
            itemExtent: 40,
            scrollController: FixedExtentScrollController(
              initialItem: heightInCm - minCm,
            ),
            onSelectedItemChanged: (int index) {
              onHeightChangedCm(cmList[index]);
            },
            changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
            children: List<Widget>.generate(cmList.length, textWidget),
          );
  }

  Widget textWidget(int index) {
    final dynamic item = isHeightInFt ? ftList[index] : cmList[index];

    final String ft = LanguagesUtil().heightUnitFeetInches;
    final String cm = LanguagesUtil().heightUnitCm;

    return CustomText(
      data: "$item ${isHeightInFt ? ft : cm}",
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
