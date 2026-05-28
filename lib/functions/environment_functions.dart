import "dart:convert";
import "dart:developer";

import "package:connector/environment/environment.dart" as current;
import "package:horizon/environment/environment.dart" as structure;

void setEnvironmentConfig() {
  try {
    final String jsonString = jsonEncode(current.Environment().toMap());

    structure.Environment().loadFromJson(jsonString);
  } on Object catch (error, stackTrace) {
    log("Exception", error: error, stackTrace: stackTrace);
  } finally {}

  return;
}
