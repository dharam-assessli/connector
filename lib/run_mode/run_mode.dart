import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:material_ui/material_ui.dart";

enum RunModesEnum { debug, profile, release, unknown }

class RunMode {
  factory RunMode() {
    return _singleton;
  }

  RunMode._internal();
  static final RunMode _singleton = RunMode._internal();

  RunModesEnum get getRunMode {
    return kDebugMode
        ? RunModesEnum.debug
        : kProfileMode
        ? RunModesEnum.profile
        : kReleaseMode
        ? RunModesEnum.release
        : RunModesEnum.unknown;
  }

  Widget wrapWithBanner(final Widget child) {
    return getRunMode != RunModesEnum.release
        ? Banner(
            location: BannerLocation.topStart,
            message: getRunMode.name,
            child: child,
          )
        : child;
  }
}
