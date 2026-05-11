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
}
