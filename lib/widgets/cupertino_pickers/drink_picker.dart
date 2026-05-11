import "package:connector/functions/onboarding/drink_functions.dart";
import "package:flutter/cupertino.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class DrinkPicker extends StatelessWidget {
  const DrinkPicker({
    required this.drink,
    required this.onDrinkChanged,
    super.key,
  });

  final DrinkEnum drink;
  final void Function(DrinkEnum value) onDrinkChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      key: const Key("drink"),
      itemExtent: 40,
      scrollController: FixedExtentScrollController(
        initialItem: drinkList.indexOf(drink),
      ),
      onSelectedItemChanged: (int index) {
        onDrinkChanged(drinkList[index]);
      },
      changeReportingBehavior: ChangeReportingBehavior.onScrollEnd,
      children: List<Widget>.generate(drinkList.length, textWidget),
    );
  }

  Widget textWidget(int index) {
    return CustomText(
      data: drinkList[index].value,
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
