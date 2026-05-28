import "dart:developer";

import "package:get/get.dart";
import "package:horizon/automations/manual_automations/health_data_automation.dart"
    as health_data_automation;
import "package:horizon/automations/manual_automations/location_data_automation.dart"
    as location_data_automation;
import "package:horizon/automations/manual_automations/location_data_automation_2.dart"
    as location_data_automation_2;
import "package:horizon/automations/manual_automations/screen_data_automation.dart"
    as screen_data_automation;
import "package:horizon/models/connector/get_health.dart";
import "package:horizon/models/connector/get_screen.dart";
// import "package:uuid/uuid.dart";

class ManualSyncController extends GetxController {
  final Rx<DateTime> rxStrDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).obs;
  final Rx<DateTime> rxEndDateTime = DateTime.now().obs;

  void updateStrDateTime(final DateTime dateTime) {
    rxStrDateTime.value = dateTime;

    return;
  }

  void updateEndDateTime(final DateTime dateTime) {
    rxEndDateTime.value = dateTime;

    return;
  }

  Future<void> syncLocationData() async {
    try {
      // Type 1
      await location_data_automation.startAutomation();
      // Type 2
      await location_data_automation_2.startAutomation();
    } on Object catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  Future<void> syncHealthData() async {
    try {
      final GetHealth get = GetHealth(
        // requestId: null,
        windowStart: rxStrDateTime.value.toIso8601String(),
        windowEnd: rxEndDateTime.value.toIso8601String(),
        intervals: 3600,
        isManual: true,
      );

      await health_data_automation.startAutomation(get: get);
    } on Object catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  Future<void> syncScreenData() async {
    try {
      final GetScreen get = GetScreen(
        // requestId: null,
        windowStart: rxStrDateTime.value.toIso8601String(),
        windowEnd: rxEndDateTime.value.toIso8601String(),
        intervals: 3600,
        isManual: true,
      );

      await screen_data_automation.startAutomation(get: get);
    } on Object catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }
}
