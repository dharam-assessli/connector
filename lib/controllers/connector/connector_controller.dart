import "package:connector/utils/help_sheets.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get.dart";
import "package:horizon/automations/foreground_automations/health_data_automation.dart"
    as health_data_automation;
import "package:horizon/automations/foreground_automations/location_data_automation.dart"
    as location_data_automation;
import "package:horizon/automations/foreground_automations/screen_data_automation.dart"
    as screen_data_automation;
import "package:horizon/services/health_service.dart";
import "package:horizon/services/location_service.dart";
import "package:horizon/services/permission_service.dart";
import "package:horizon/services/screen_time_service.dart";
import "package:permission_handler/permission_handler.dart";

class ConnectorController extends GetxController {
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
    final bool hasServices = await LocationService().checkServices();
    if (!hasServices) {
      await Geolocator.openLocationSettings();
      return Future<void>.value();
    }

    final bool hasPermissions = await LocationService().checkPermissionsFG();
    if (!hasPermissions) {
      await Geolocator.openAppSettings();
      return Future<void>.value();
    }

    final bool alwaysPermission = await LocationService().checkPermissionsBG();
    if (!alwaysPermission) {
      await Geolocator.openAppSettings();
      return Future<void>.value();
    }

    await Geolocator.openAppSettings();

    return Future<void>.value();
  }

  Future<void> onSettingsTapTapHealth() async {
    final bool isSDKAvailable = await HealthService().sdkAvailable();
    if (!isSDKAvailable) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool hasConfigured = await HealthService().configure();
    if (!hasConfigured) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool hasPermissions = await HealthService().checkPermissions();
    if (!hasPermissions) {
      await Geolocator.openAppSettings();
      return Future<void>.value();
    }

    final bool hasAuthorized = await HealthService().requestAuthorization();
    if (!hasAuthorized) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    final bool hasSetupBackground = await HealthService().setupBackground();
    if (!hasSetupBackground) {
      await HealthService().openHealth();
      return Future<void>.value();
    }

    await HealthService().openHealth();

    return Future<void>.value();
  }

  Future<void> onSettingsTapScreenTime() async {
    await ScreenTimeService().requestPermission();

    return Future<void>.value();
  }

  Future<void> onSettingsTapNotification() async {
    await Geolocator.openAppSettings();

    return Future<void>.value();
  }
}
