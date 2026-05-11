import "package:get/get.dart";

enum GenderEnum {
  preferNotToSay("genderPreferNotToSay"),
  male("genderMale"),
  female("genderFemale"),
  nonBinary("genderNonBinary");

  const GenderEnum(this.key);

  final String key;

  String get value {
    return key.tr;
  }
}

const GenderEnum defaultGender = GenderEnum.preferNotToSay;

const List<GenderEnum> genderList = GenderEnum.values;
