class ImagesConstants {
  factory ImagesConstants() {
    return _singleton;
  }

  ImagesConstants._internal();
  static final ImagesConstants _singleton = ImagesConstants._internal();

  String get appIcon => "assets/images/app_icon_transparent.png";
  String get signInWithGoogle => "assets/images/google_sign_in.svg";
  String get signInWithApple => "assets/images/apple_sign_in.svg";

  // Home Tab Images
  String get homeHuman => "assets/images/home_human.png";

  // Navigation Bar Images
  String get navHome => "assets/images/nav_home.png";
  String get navFeed => "assets/images/nav_feed.png";
  String get navVoice => "assets/images/nav_voice.png";
  String get navCommunity => "assets/images/nav_community.png";
  String get navHub => "assets/images/nav_hub.png";
  String get navTwin => "assets/images/nav_twin.png";
}
