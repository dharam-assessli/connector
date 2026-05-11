import "package:connector/models/auth/user.dart";

class VerifyOTP {
  VerifyOTP({this.accessToken, this.refreshToken, this.user});

  VerifyOTP.fromJson(Map<String, dynamic> json) {
    accessToken = json["access_token"];
    refreshToken = json["refresh_token"];
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  String? accessToken;
  String? refreshToken;
  User? user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["access_token"] = accessToken;
    data["refresh_token"] = refreshToken;
    if (user != null) {
      data["user"] = user!.toJson();
    }

    return data;
  }
}
