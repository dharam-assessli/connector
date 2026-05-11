import "package:get/get.dart";

enum AstronomyEnum {
  aries("astronomyAries"),
  taurus("astronomyTaurus"),
  gemini("astronomyGemini"),
  cancer("astronomyCancer"),
  leo("astronomyLeo"),
  virgo("astronomyVirgo"),
  libra("astronomyLibra"),
  scorpio("astronomyScorpio"),
  sagittarius("astronomySagittarius"),
  capricorn("astronomyCapricorn"),
  aquarius("astronomyAquarius"),
  pisces("astronomyPisces");

  const AstronomyEnum(this.key);

  final String key;

  String get value {
    return key.tr;
  }
}

const AstronomyEnum defaultAstronomy = AstronomyEnum.aries;

const List<AstronomyEnum> astronomyList = AstronomyEnum.values;

const List<String> emoji = <String>[
  "♈",
  "♉",
  "♊",
  "♋",
  "♌",
  "♍",
  "♎",
  "♏",
  "♐",
  "♑",
  "♒",
  "♓",
];
