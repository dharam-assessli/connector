import "package:connector/utils/help_sheets.dart";
import "package:get/get.dart";
import "package:horizon/automations/foreground_automations/health_data_automation.dart"
    as health_data_automation;
import "package:horizon/automations/foreground_automations/location_data_automation.dart"
    as location_data_automation;
import "package:horizon/automations/foreground_automations/screen_data_automation.dart"
    as screen_data_automation;
import "package:horizon/services/battery_service.dart";
import "package:horizon/services/health_service.dart";
import "package:horizon/services/location_service.dart";
import "package:horizon/services/permission_service.dart";
import "package:horizon/services/screen_time_service.dart";
import "package:permission_handler/permission_handler.dart";

class ConnectorController extends GetxController {
  final RxBool rxisDisabledOptimization = false.obs;

  @override
  Future<void> onReady() async {
    super.onReady();

    // Check battery optimization status on ready and update reactive variable
    rxisDisabledOptimization.value = await isDisabledOptimization();
  }

  Future<void> onItemTapLocation() async {
    await location_data_automation.startAutomation();

    return Future<void>.value();
  }

  Future<void> onItemTapHealth() async {
    await health_data_automation.startAutomation();

    return Future<void>.value();
  }

  Future<void> onItemTapScreenTime() async {
    await screen_data_automation.startAutomation();

    return Future<void>.value();
  }

  Future<void> onItemTapNotification() async {
    const Permission permission = Permission.notification;

    await PermissionService().checkPermission(permission: permission);

    return Future<void>.value();
  }

  //

  Future<void> onHelpTapLocation() async {
    await introLocationSheet();

    return Future<void>.value();
  }

  Future<void> onHelpTapHealth() async {
    await introHealthSheet();

    return Future<void>.value();
  }

  Future<void> onHelpTapScreenTime() async {
    await introScreenSheet();

    return Future<void>.value();
  }

  Future<void> onHelpTapNotification() async {
    await introNotificationSheet();

    return Future<void>.value();
  }

  //

  Future<void> onSettingsTapLocation() async {
    final bool condition1 = await LocationService().checkServices();
    if (!condition1) {
      await PermissionService().openLocationSettings();
      return Future<void>.value();
    }

    final bool condition2 = await LocationService().checkPermissionsFG();
    if (!condition2) {
      await PermissionService().openAppSettings();
      return Future<void>.value();
    }

    final bool condition3 = await LocationService().checkPermissionsBG();
    if (!condition3) {
      await PermissionService().openAppSettings();
      return Future<void>.value();
    }

    await PermissionService().openAppSettings();

    return Future<void>.value();
  }

  Future<void> onSettingsTapTapHealth() async {
    final bool condition1 = await HealthService().sdkAvailable();
    if (!condition1) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool condition2 = await HealthService().configure();
    if (!condition2) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool condition3 = await HealthService().checkPermissions();
    if (!condition3) {
      await PermissionService().openAppSettings();
      return Future<void>.value();
    }

    final bool condition4 = await HealthService().requestAuthorization();
    if (!condition4) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool condition5 = await HealthService().setupBackground();
    if (!condition5) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool condition6 = await HealthService().hasPermission();
    if (!condition6) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    await HealthService().openHealth();

    return Future<void>.value();
  }

  Future<void> onSettingsTapScreenTime() async {
    final bool condition = await ScreenTimeService().hasPermission();

    if (!condition) {
      await ScreenTimeService().requestPermission();
      return Future<void>.value();
    }

    await ScreenTimeService().requestPermission();

    return Future<void>.value();
  }

  Future<void> onSettingsTapNotification() async {
    await PermissionService().openAppSettings();

    return Future<void>.value();
  }

  //

  Future<bool> isDisabledOptimization() async {
    final bool value = await BatteryService().isBatteryOptimizationDisabled();

    return Future<bool>.value(value);
  }

  Future<void> openBatteryOptimizationSettings() async {
    await BatteryService().openBatteryOptimizationSettings();

    return Future<void>.value();
  }
}
