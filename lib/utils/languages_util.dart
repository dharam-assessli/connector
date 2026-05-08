import "package:get/get.dart";

class LanguagesUtil {
  factory LanguagesUtil() {
    return _singleton;
  }

  LanguagesUtil._internal();
  static final LanguagesUtil _singleton = LanguagesUtil._internal();

  String get appName => "appName".tr;
  String get signInWithGoogle => "signInWithGoogle".tr;
  String get signInWithApple => "signInWithApple".tr;
  String get byContinuingYouAgreeToOur => "byContinuingYouAgreeToOur".tr;
  String get termsOfService => "termsOfService".tr;
  String get and => "and".tr;
  String get privacyPolicy => "privacyPolicy".tr;
  String get introLocationHeading => "introLocationHeading".tr;
  String get introLocationTopDescription => "introLocationTopDescription".tr;
  String get introLocationBtmDescription => "introLocationBtmDescription".tr;
  String get introHealthHeading => "introHealthHeading".tr;
  String get introHealthTopDescription => "introHealthTopDescription".tr;
  String get introHealthBtmDescription => "introHealthBtmDescription".tr;
  String get introScreenHeading => "introScreenHeading".tr;
  String get introScreenTopDescription => "introScreenTopDescription".tr;
  String get introScreenBtmDescription => "introScreenBtmDescription".tr;
  String get connectorHeading => "connectorHeading".tr;
  String get connectorTopDescription => "connectorTopDescription".tr;
  String get connectorBtmDescription => "connectorBtmDescription".tr;
  String get introNotificationHeading => "introNotificationHeading".tr;
  String get introNotificationTopDescription =>
      "introNotificationTopDescription".tr;
  String get introNotificationBtmDescription =>
      "introNotificationBtmDescription".tr;
  String get reassurance => "reassurance".tr;
  String get connector => "connector".tr;
  String get profile => "profile".tr;
  String get location => "location".tr;
  String get health => "health".tr;
  String get screenTime => "screenTime".tr;
  String get sync => "sync".tr;
  String get tapToResync => "tapToResync".tr;
  String get openSettings => "openSettings".tr;
  String get notifications => "notifications".tr;
  String get signOut => "signOut".tr;
String get understood=> "understood".tr;
}
