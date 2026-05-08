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
}
