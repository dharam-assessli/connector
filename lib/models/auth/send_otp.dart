class SendOTP {
  SendOTP({this.expiresIn, this.appSignature});

  SendOTP.fromJson(Map<String, dynamic> json) {
    expiresIn = json["expires_in"];
    appSignature = json["app_signature"];
  }

  int? expiresIn;
  String? appSignature;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["expires_in"] = expiresIn;
    data["app_signature"] = appSignature;
    
    return data;
  }
}
