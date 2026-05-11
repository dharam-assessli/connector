import "package:get/get.dart";

enum DrinkEnum {
  preferNotToSay("drinkPreferNotToSay"),
  yes("drinkYes"),
  no("drinkNo"),
  regularly("drinkRegularly"),
  rarely("drinkRarely");

  const DrinkEnum(this.key);

  final String key;

  String get value {
    return key.tr;
  }
}

const DrinkEnum defaultDrink = DrinkEnum.preferNotToSay;

const List<DrinkEnum> drinkList = DrinkEnum.values;
