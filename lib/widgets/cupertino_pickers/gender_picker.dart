import "package:connector/functions/onboarding/gender_functions.dart";
import "package:flutter/cupertino.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    required this.gender,
    required this.onGenderChanged,
    super.key,
  });

  final GenderEnum gender;
  final void Function(GenderEnum value) onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      key: const Key("gender"),
      itemExtent: 40,
      scrollController: FixedExtentScrollController(
        initialItem: genderList.indexOf(gender),
      ),
      onSelectedItemChanged: (int index) {
        onGenderChanged(genderList[index]);
      },
      changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
      children: List<Widget>.generate(genderList.length, textWidget),
    );
  }

  Widget textWidget(int index) {
    return CustomText(
      data: genderList[index].value,
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
