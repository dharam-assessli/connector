import "package:material_ui/material_ui.dart";

class ColorsConstants {
  factory ColorsConstants() {
    return _singleton;
  }

  ColorsConstants._internal();
  static final ColorsConstants _singleton = ColorsConstants._internal();

  Color get transparent => Colors.transparent;

  Color get grey => Colors.grey;
  Color get green => Colors.green;
  Color get purple => Colors.purple;
  Color get red => Colors.red;
  Color get yellow => Colors.yellow;
  Color get white => Colors.white;
  Color get blue => Colors.blue;
  Color get neonGreen => const Color(0xFFC6FF0A);
}
