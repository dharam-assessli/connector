// enum
enum Mood {
  heart,
  // bun,
  // pixelTriangle,
  // pixelCircle,
  // ghostish,
  puffyDiamond,
  puffy,
  flower,
  softBloom,
  // bloom,
  softBurst,
  // burst,
  eightLeafClover,
  fourLeafClover,
  twelveSidedCookie,
  // nineSidedCookie,
  // sevenSidedCookie,
  sixSidedCookie,
  // fourSidedCookie,
  sunny,
  // verySunny,
  gem,
  pentagon,
  clampShell,
  // diamond,
  // fan,
  // arrow,
  // triangle,
  // pill,
  // oval,
  // semicircle,
  // arch,
  // slanted,
  // square,
  circle,
}

String buildLabel(Mood mood) {
  final String name = mood.name;

  final String spaced = name.replaceAllMapped(RegExp("([A-Z])"), (Match m) {
    return " ${m[1]}";
  });

  final String trimmed = spaced.trim();

  if (trimmed.isEmpty) {
    return "";
  }

  return trimmed[0].toUpperCase() + trimmed.substring(1);
}
