import "package:material_ui/material_ui.dart";

class ColorsConstants {
  factory ColorsConstants() {
    return _singleton;
  }

  ColorsConstants._internal();
  static final ColorsConstants _singleton = ColorsConstants._internal();

  Color get transparent => Colors.transparent;
  Color get green => Colors.green;
  Color get black => Colors.black;
  Color get grey => Colors.grey;
  Color get white => Colors.white;
}
