import "dart:convert";
import "dart:developer";

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();
  static final Environment _singleton = Environment._internal();

  String appVarName = const String.fromEnvironment("appVarName");
  String apiBaseURL = const String.fromEnvironment("apiBaseURL");
  String middleware = const String.fromEnvironment("middleware");
  String apiVersion = const String.fromEnvironment("apiVersion");

  void setConfig({
    final String? appVarName,
    final String? apiBaseURL,
    final String? middleware,
    final String? apiVersion,
  }) {
    this.appVarName = appVarName ?? this.appVarName;
    this.apiBaseURL = apiBaseURL ?? this.apiBaseURL;
    this.middleware = middleware ?? this.middleware;
    this.apiVersion = apiVersion ?? this.apiVersion;

    return;
  }

  void loadFromJson(final String jsonString) {
    try {
      final Map<String, dynamic> configMap = jsonDecode(jsonString);

      appVarName = configMap["appVarName"] ?? appVarName;
      apiBaseURL = configMap["apiBaseURL"] ?? apiBaseURL;
      middleware = configMap["middleware"] ?? middleware;
      apiVersion = configMap["apiVersion"] ?? apiVersion;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return;
  }

  Map<String, String> toMap() {
    return <String, String>{
      "appVarName": appVarName,
      "apiBaseURL": apiBaseURL,
      "middleware": middleware,
      "apiVersion": apiVersion,
    };
  }

  @override
  String toString() {
    return "Environment(${toMap()})";
  }
}
