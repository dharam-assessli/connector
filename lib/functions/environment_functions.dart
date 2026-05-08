import "dart:convert";

import "package:connector/environment/environment.dart" as current;
import "package:horizon/environment/environment.dart" as structure;

void setEnvironmentConfig() {
  final String jsonString = jsonEncode(current.Environment().toMap());

  structure.Environment().loadFromJson(jsonString);

  return;
}
