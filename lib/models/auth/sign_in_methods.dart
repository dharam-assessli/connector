class SignInMethods {
  SignInMethods({this.methods});

  SignInMethods.fromJson(Map<String, dynamic> json) {
    methods = (json["methods"] as List<dynamic>).cast<String>();
  }

  List<String>? methods;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["methods"] = methods;

    return data;
  }
}
