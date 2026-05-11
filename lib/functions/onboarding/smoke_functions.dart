import "package:get/get.dart";

enum SmokeEnum {
  preferNotToSay("smokePreferNotToSay"),
  yes("smokeYes"),
  no("smokeNo"),
  regularly("smokeRegularly"),
  rarely("smokeRarely");

  const SmokeEnum(this.key);

  final String key;

  String get value {
    return key.tr;
  }
}

const SmokeEnum defaultSmoke = SmokeEnum.preferNotToSay;

const List<SmokeEnum> smokeList = SmokeEnum.values;
