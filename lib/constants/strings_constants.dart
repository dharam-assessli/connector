import "package:google_maps_flutter/google_maps_flutter.dart";

class StringsConstants {
  factory StringsConstants() {
    return _singleton;
  }

  StringsConstants._internal();
  static final StringsConstants _singleton = StringsConstants._internal();

  String get appName => "Dotsin Connector";

  String get storeAndroidID => "com.assessli.connector";
  String get storeAppleID => "6446764418";

  String get remoteConfigMaintenanceKey => "is_under_maintenance";
  String get appMaintenanceURL => "https://example.com";

  String get privacyPolicyURL => "https://www.assessli.com/privacy-policy";
  String get tAndCURL => "https://www.assessli.com/terms-and-conditions";

  String get supportPhoneNumber => "+917208729629";
  String get supportWhatsAppNumber => "+917208729629";
  String get supportSMSNumber => "+917208729629";
  String get supportEmail => "sg@assessli.com";
  String get supportWebsite => "https://www.assessli.com/contactus";

  String get supportLocationTitle => "Assessli";
  String get supportLatLong => "12.933381550595675, 77.62152392427426";

  String get name => "Dharam";

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
