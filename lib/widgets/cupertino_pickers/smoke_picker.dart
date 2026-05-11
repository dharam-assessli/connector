import "package:connector/functions/onboarding/smoke_functions.dart";
import "package:flutter/cupertino.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class SmokePicker extends StatelessWidget {
  const SmokePicker({
    required this.smoke,
    required this.onSmokeChanged,
    super.key,
  });

  final SmokeEnum smoke;
  final void Function(SmokeEnum value) onSmokeChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      key: const Key("smoke"),
      itemExtent: 40,
      scrollController: FixedExtentScrollController(
        initialItem: smokeList.indexOf(smoke),
      ),
      onSelectedItemChanged: (int index) {
        onSmokeChanged(smokeList[index]);
      },
      changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
      children: List<Widget>.generate(smokeList.length, textWidget),
    );
  }

  Widget textWidget(int index) {
    return CustomText(
      data: smokeList[index].value,
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
