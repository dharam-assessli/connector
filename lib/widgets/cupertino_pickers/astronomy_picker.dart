import "package:connector/functions/onboarding/astronomy_functions.dart";
import "package:flutter/cupertino.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class AstronomyPicker extends StatelessWidget {
  const AstronomyPicker({
    required this.astronomy,
    required this.onAstronomyChanged,
    super.key,
  });

  final AstronomyEnum astronomy;
  final void Function(AstronomyEnum value) onAstronomyChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      key: const Key("astronomy"),
      itemExtent: 40,
      scrollController: FixedExtentScrollController(
        initialItem: astronomyList.indexOf(astronomy),
      ),
      onSelectedItemChanged: (int index) {
        onAstronomyChanged(astronomyList[index]);
      },
      changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
      children: List<Widget>.generate(astronomyList.length, textWidget),
    );
  }

  Widget textWidget(int index) {
    return CustomText(
      data: "${emoji[index]} ${astronomyList[index].value}",
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
