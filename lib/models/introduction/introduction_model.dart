import "package:connector/utils/languages_util.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:material_ui/material_ui.dart";

// Model
class IntroductionModel {
  IntroductionModel({
    required this.icon,
    required this.heading,
    required this.topDescription,
    required this.bottomDescription,
  });

  final Widget icon;
  final String heading;
  final String topDescription;
  final String bottomDescription;
}

final IntroductionModel introLocationForeground = IntroductionModel(
  icon: const FaIcon(FontAwesomeIcons.mapLocationDot, size: 56.0),
  heading: LanguagesUtil().introLocationHeadingFG,
  topDescription: LanguagesUtil().introLocationTopDescriptionFG,
  bottomDescription: LanguagesUtil().introLocationBtmDescriptionFG,
);

final IntroductionModel introLocationBackground = IntroductionModel(
  icon: const FaIcon(FontAwesomeIcons.mapLocationDot, size: 56.0),
  heading: LanguagesUtil().introLocationHeadingBG,
  topDescription: LanguagesUtil().introLocationTopDescriptionBG,
  bottomDescription: LanguagesUtil().introLocationBtmDescriptionBG,
);

final IntroductionModel introHealth = IntroductionModel(
  icon: const FaIcon(FontAwesomeIcons.heartPulse, size: 56.0),
  heading: LanguagesUtil().introHealthHeading,
  topDescription: LanguagesUtil().introHealthTopDescription,
  bottomDescription: LanguagesUtil().introHealthBtmDescription,
);

final IntroductionModel introScreen = IntroductionModel(
  icon: const FaIcon(FontAwesomeIcons.chartColumn, size: 56.0),
  heading: LanguagesUtil().introScreenHeading,
  topDescription: LanguagesUtil().introScreenTopDescription,
  bottomDescription: LanguagesUtil().introScreenBtmDescription,
);

final IntroductionModel introNotification = IntroductionModel(
  icon: const FaIcon(FontAwesomeIcons.solidBell, size: 56.0),
  heading: LanguagesUtil().introNotificationHeading,
  topDescription: LanguagesUtil().introNotificationTopDescription,
  bottomDescription: LanguagesUtil().introNotificationBtmDescription,
);
