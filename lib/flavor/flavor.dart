import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:material_ui/material_ui.dart";

enum FlavorsEnum { development, staging, production, unknown }

class Flavor {
  factory Flavor() {
    return _singleton;
  }

  Flavor._internal();
  static final Flavor _singleton = Flavor._internal();

  FlavorsEnum get getFlavor {
    switch (currentFlavor) {
      case "development":
        return FlavorsEnum.development;

      case "staging":
        return FlavorsEnum.staging;

      case "production":
        return FlavorsEnum.production;

      default:
        return FlavorsEnum.unknown;
    }
  }

  String? get currentFlavor {
    return appFlavor;
  }

  Widget wrapWithBanner(final Widget child) {
    return getFlavor != FlavorsEnum.production
        ? Banner(
            location: BannerLocation.topEnd,
            message: currentFlavor ?? "unknown",
            child: child,
          )
        : child;
  }
}
