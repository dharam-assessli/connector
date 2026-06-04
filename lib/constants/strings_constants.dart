import "package:google_maps_flutter/google_maps_flutter.dart";

const String storeAndroidPrefix =
    "https://play.google.com/store/apps/details?id=";
const String storeiOSPrefix = "https://apps.apple.com/us/app/";

class StringsConstants {
  factory StringsConstants() {
    return _singleton;
  }

  StringsConstants._internal();
  static final StringsConstants _singleton = StringsConstants._internal();

  String get appName => "Dotsin Connector";

  String get storeAndroid => "${storeAndroidPrefix}com.assessli.connector";
  String get storeiOS => "${storeiOSPrefix}dotsin-connector/id6769772549";

  String get remoteConfigMaintenanceKey => "is_under_maintenance";
  String get appMaintenanceURL => "https://www.dotsin.ai";

  String get privacyPolicyURL => "https://www.dotsin.ai/privacy-policy";
  String get tAndCURL => "https://www.dotsin.ai/terms-and-conditions";
  String get supportWebsite => "https://www.dotsin.ai/help-and-support";
  String get generalFAQsURL => "https://www.dotsin.ai/faqs";
  String get dataUsageDisclosureURL =>
      "https://www.dotsin.ai/data-usage-disclosure";
  String get aboutUs => "https://www.dotsin.ai/about-us";

  String get supportPhoneNumber => "+917208729629";
  String get supportWhatsAppNumber => "+917208729629";
  String get supportSMSNumber => "+917208729629";
  String get supportEmail => "sg@assessli.com";
  String get supportLocationTitle => "Assessli";
  String get supportLatLong => "12.933381550595675, 77.62152392427426";

  double get defaultLat => 12.9259;
  double get defaultLng => 77.6229;

  List<LatLng> get defaultPolygonPoints => const <LatLng>[
    LatLng(12.9395, 77.6180),
    LatLng(12.9405, 77.6280),
    LatLng(12.9350, 77.6360),
    LatLng(12.9260, 77.6380),
    LatLng(12.9170, 77.6340),
    LatLng(12.9140, 77.6240),
    LatLng(12.9180, 77.6150),
    LatLng(12.9280, 77.6120),
    LatLng(12.9395, 77.6180),
  ];
}
