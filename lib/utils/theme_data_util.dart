import "package:get/get.dart";
import "package:horizon/services/gradient_service.dart";
import "package:material_ui/material_ui.dart";

class ThemeDataUtil {
  factory ThemeDataUtil() {
    return _singleton;
  }

  ThemeDataUtil._internal();
  static final ThemeDataUtil _singleton = ThemeDataUtil._internal();

  // For light mode
  ThemeData light({required List<int> gradient}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: GradientService().getPrimaryColor(gradient: gradient),
    );
  }

  // For dark mode
  ThemeData dark({required List<int> gradient}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: GradientService().getPrimaryColor(gradient: gradient),
    );
  }

  Brightness get brightness {
    return Get.isDarkMode ? Brightness.dark : Brightness.light;
  }
}
