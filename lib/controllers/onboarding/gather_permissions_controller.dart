// ignore_for_file: lines_longer_than_80_chars, avoid_redundant_argument_values

import "dart:developer";
import "dart:io";

import "package:connector/utils/languages_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/services/battery_service.dart";
import "package:horizon/services/health_service.dart";
import "package:horizon/services/location_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/services/permission_service.dart";
import "package:horizon/services/screen_time_service.dart";
import "package:permission_handler/permission_handler.dart";

enum PermissionType {
  location,
  health,
  notification,
  screenTime,
  batteryOptimization,
}

class GatherPermissionsController extends GetxController
    with WidgetsBindingObserver {
  final PageController pageController = PageController();

  final RxInt rxCurrentPage = 0.obs;

  final RxBool isLocationPermissionGranted = false.obs;
  final RxBool isHealthPermissionGranted = false.obs;
  final RxBool isNotificationPermissionGranted = false.obs;
  final RxBool isScreenTimePermissionGranted = false.obs;
  final RxBool isBatteryOptimizationDisabled = false.obs;

  final RxBool hasRequestedLocationPermission = false.obs;
  final RxBool hasRequestedHealthPermission = false.obs;
  final RxBool hasRequestedNotificationPermission = false.obs;
  final RxBool hasRequestedScreenTimePermission = false.obs;
  final RxBool hasRequestedBatteryOptimization = false.obs;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(final AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    state == AppLifecycleState.resumed ? await onResume() : (() {})();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    super.onClose();
  }

  Future<void> onResume() async {
    final List<bool> results = await Future.wait(<Future<bool>>[
      checkLocationPermission(request: false),
      checkHealthPermission(request: false),
      checkNotificationPermission(request: false),
      checkScreenTimePermission(request: false),
      checkBatteryOptimizationPermission(request: false),
    ]);

    isLocationPermissionGranted.value = results[0];
    isHealthPermissionGranted.value = results[1];
    isNotificationPermissionGranted.value = results[2];
    isScreenTimePermissionGranted.value = results[3];
    isBatteryOptimizationDisabled.value = results[4];

    return Future<void>.value();
  }

  Future<void> requestLocationPermission() async {
    try {
      if (hasRequestedLocationPermission.value) {
        await openLocationPermission();
        isLocationPermissionGranted.value = await checkLocationPermission(
          request: false,
        );
        return;
      }

      isLocationPermissionGranted.value = await checkLocationPermission(
        request: true,
      );
      hasRequestedLocationPermission.value = true;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    }

    return Future<void>.value();
  }

  Future<void> requestHealthPermission() async {
    try {
      if (hasRequestedHealthPermission.value) {
        await openHealthPermission();
        isHealthPermissionGranted.value = await checkHealthPermission(
          request: false,
        );
        return;
      }

      isHealthPermissionGranted.value = await checkHealthPermission(
        request: true,
      );
      hasRequestedHealthPermission.value = true;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    }

    return Future<void>.value();
  }

  Future<void> requestNotificationPermission() async {
    try {
      if (hasRequestedNotificationPermission.value) {
        await openNotificationPermission();
        isNotificationPermissionGranted.value =
            await checkNotificationPermission(request: false);
        return;
      }

      isNotificationPermissionGranted.value = await checkNotificationPermission(
        request: true,
      );
      hasRequestedNotificationPermission.value = true;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    }

    return Future<void>.value();
  }

  Future<void> requestScreenTimePermission() async {
    try {
      if (hasRequestedScreenTimePermission.value) {
        await openScreenTimePermission();
        isScreenTimePermissionGranted.value = await checkScreenTimePermission(
          request: false,
        );
        return;
      }

      isScreenTimePermissionGranted.value = await checkScreenTimePermission(
        request: true,
      );
      hasRequestedScreenTimePermission.value = true;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    }

    return Future<void>.value();
  }

  Future<void> requestBatteryOptimizationPermission() async {
    try {
      if (hasRequestedBatteryOptimization.value) {
        await openBatteryOptimizationPermission();
        isBatteryOptimizationDisabled.value =
            await checkBatteryOptimizationPermission(request: false);
        return;
      }

      isBatteryOptimizationDisabled.value =
          await checkBatteryOptimizationPermission(request: true);
      hasRequestedBatteryOptimization.value = true;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    }

    return Future<void>.value();
  }

  Future<bool> checkLocationPermission({required bool request}) async {
    bool value = false;

    try {
      final bool condition1 = await LocationService().checkServices(
        request: request,
      );
      if (!condition1) {
        // SnackBarUtil().show("Location services are disabled.");
        return Future<bool>.value(value);
      }

      final bool condition2 = await LocationService().checkPermissionsFG(
        request: request,
      );
      if (!condition2) {
        // SnackBarUtil().show("Location permission (foreground) is not granted.");
        return Future<bool>.value(value);
      }

      final bool condition3 = await LocationService().checkPermissionsBG(
        request: request,
      );
      if (!condition3) {
        // SnackBarUtil().show("Location permission (background) is not granted.");
        return Future<bool>.value(value);
      }

      value = condition1 && condition2 && condition3;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<bool>.value(value);
  }

  Future<bool> checkHealthPermission({required bool request}) async {
    bool value = false;

    try {
      final bool condition1 = await HealthService().sdkAvailable();
      if (!condition1) {
        // SnackBarUtil().show("Health Connect SDK is not available.");
        return Future<bool>.value(value);
      }

      final bool condition2 = await HealthService().configure();
      if (!condition2) {
        // SnackBarUtil().show("Health Connect SDK configuration failed.");
        return Future<bool>.value(value);
      }

      final bool condition3 = await HealthService().checkPermissions(
        request: request,
      );
      if (!condition3) {
        // SnackBarUtil().show("Health permission is not granted.");
        return Future<bool>.value(value);
      }

      bool condition4 = true;
      bool condition5 = true;

      if (request) {
        condition4 = await HealthService().requestAuthorization();
        if (!condition4) {
          // SnackBarUtil().show("Health authorization request is not granted.");
          return Future<bool>.value(value);
        }

        condition5 = await HealthService().setupBackground();
        if (!condition5) {
          // SnackBarUtil().show("Health background setup failed.");
          return Future<bool>.value(value);
        }
      }

      final bool condition6 = await HealthService().hasPermission();
      if (!condition6) {
        // SnackBarUtil().show("Health permission is not granted.");
        return Future<bool>.value(value);
      }

      value = request
          ? condition1 &&
                condition2 &&
                condition3 &&
                condition4 &&
                condition5 &&
                condition6
          : condition1 && condition2 && condition3 && condition6;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<bool>.value(value);
  }

  Future<bool> checkNotificationPermission({required bool request}) async {
    bool value = false;

    try {
      final bool condition = await PermissionService().checkPermission(
        permission: Permission.notification,
        request: request,
      );
      if (!condition) {
        // SnackBarUtil().show("Notification permission is not granted.");
        return Future<bool>.value(value);
      }

      value = condition;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<bool>.value(value);
  }

  Future<bool> checkScreenTimePermission({required bool request}) async {
    bool value = false;

    try {
      final bool condition = await ScreenTimeService().hasPermission();
      if (!condition) {
        // SnackBarUtil().show("Screen Time permission is not granted.");
        return Future<bool>.value(value);
      }

      value = condition;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<bool>.value(value);
  }

  Future<bool> checkBatteryOptimizationPermission({
    required bool request,
  }) async {
    bool value = false;

    try {
      final bool condition = await BatteryService().isDisabledOptimization();
      if (!condition) {
        // SnackBarUtil().show("Battery optimization is not disabled.");
        return Future<bool>.value(value);
      }

      value = condition;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<bool>.value(value);
  }

  Future<void> openLocationPermission() async {
    try {
      final bool condition1 = await LocationService().checkServices(
        request: false,
      );
      if (!condition1) {
        await PermissionService().openLocationSettings();
        // SnackBarUtil().show("Opening location settings");
        return Future<void>.value();
      }

      final bool condition2 = await LocationService().checkPermissionsFG(
        request: false,
      );
      if (!condition2) {
        await PermissionService().openAppSettings();
        // SnackBarUtil().show("Opening app settings");
        return Future<void>.value();
      }

      final bool condition3 = await LocationService().checkPermissionsBG(
        request: false,
      );
      if (!condition3) {
        await PermissionService().openAppSettings();
        // SnackBarUtil().show("Opening app settings");
        return Future<void>.value();
      }
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  Future<void> openHealthPermission() async {
    try {
      final bool condition1 = await HealthService().sdkAvailable();
      if (!condition1) {
        // SnackBarUtil().show("Health Connect SDK is not available.");
        await HealthService().openHealth();
        return Future<void>.value();
      }

      final bool condition2 = await HealthService().configure();
      if (!condition2) {
        // SnackBarUtil().show("Health Connect SDK configuration failed.");
        await HealthService().openHealth();
        return Future<void>.value();
      }

      final bool condition3 = await HealthService().checkPermissions(
        request: false,
      );
      if (!condition3) {
        // SnackBarUtil().show("Health permission is not granted.");
        await PermissionService().openAppSettings();
        return Future<void>.value();
      }

      final bool condition4 = await HealthService().requestAuthorization();
      if (!condition4) {
        // SnackBarUtil().show("Health authorization request is not granted.");
        await HealthService().openHealth();
        return Future<void>.value();
      }

      final bool condition5 = await HealthService().setupBackground();
      if (!condition5) {
        // SnackBarUtil().show("Health background setup failed.");
        await HealthService().openHealth();
        return Future<void>.value();
      }

      final bool condition6 = await HealthService().hasPermission();
      if (!condition6) {
        // SnackBarUtil().show("Health permission is not granted.");
        await HealthService().openHealth();
        return Future<void>.value();
      }
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  Future<void> openNotificationPermission() async {
    try {
      final bool condition = await PermissionService().checkPermission(
        permission: Permission.notification,
        request: false,
      );
      if (!condition) {
        await PermissionService().openAppSettings();
        // SnackBarUtil().show("Opening app settings");
        return Future<void>.value();
      }
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  Future<void> openScreenTimePermission() async {
    try {
      final bool condition = await ScreenTimeService().hasPermission();
      if (!condition) {
        await ScreenTimeService().requestPermission();
        // SnackBarUtil().show("Requesting screen time permission");
        return Future<void>.value();
      }
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  Future<void> openBatteryOptimizationPermission() async {
    try {
      final bool condition = await BatteryService().isDisabledOptimization();
      if (!condition) {
        await BatteryService().openBatteryOptimizationSettings();
        // SnackBarUtil().show("Opening battery optimization settings");
        return Future<void>.value();
      }
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<void>.value();
  }

  //

  List<PermissionType> getPermissionTypes() {
    return Platform.isAndroid
        ? <PermissionType>[
            PermissionType.location,
            PermissionType.health,
            PermissionType.notification,
            PermissionType.screenTime,
            PermissionType.batteryOptimization,
          ]
        : Platform.isIOS
        ? <PermissionType>[
            PermissionType.location,
            PermissionType.health,
            PermissionType.notification,
          ]
        : <PermissionType>[];
  }

  IconData getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.location_on_outlined;
      case 1:
        return Icons.favorite_border;
      case 2:
        return Icons.notifications_outlined;
      case 3:
        return Icons.hourglass_empty_outlined;
      case 4:
        return Icons.battery_5_bar_outlined;
      default:
        return Icons.error_outline;
    }
  }

  String getHeading(int index) {
    switch (index) {
      case 0:
        return LanguagesUtil().introLocationHeading;
      case 1:
        return LanguagesUtil().introHealthHeading;
      case 2:
        return LanguagesUtil().introNotificationHeading;
      case 3:
        return LanguagesUtil().introScreenHeading;
      case 4:
        return LanguagesUtil().introBatteryHeading;
      default:
        return "";
    }
  }

  String getTopDescription(int index) {
    switch (index) {
      case 0:
        return LanguagesUtil().introLocationTopDescription;
      case 1:
        return LanguagesUtil().introHealthTopDescription;
      case 2:
        return LanguagesUtil().introNotificationTopDescription;
      case 3:
        return LanguagesUtil().introScreenTopDescription;
      case 4:
        return LanguagesUtil().introBatteryTopDescription;
      default:
        return "";
    }
  }

  String getBtmDescription(int index) {
    switch (index) {
      case 0:
        return LanguagesUtil().introLocationBtmDescription;
      case 1:
        return LanguagesUtil().introHealthBtmDescription;
      case 2:
        return LanguagesUtil().introNotificationBtmDescription;
      case 3:
        return LanguagesUtil().introScreenBtmDescription;
      case 4:
        return LanguagesUtil().introBatteryBtmDescription;
      default:
        return "";
    }
  }

  Future<void> onTap() async {
    if (Platform.isAndroid) {
      switch (rxCurrentPage.value) {
        case 0:
          await requestLocationPermission();
          isLocationPermissionGranted.value ? await nextPage() : (() {})();
          break;

        case 1:
          await requestHealthPermission();
          isHealthPermissionGranted.value ? await nextPage() : (() {})();
          break;

        case 2:
          await requestNotificationPermission();
          isNotificationPermissionGranted.value ? await nextPage() : (() {})();
          break;

        case 3:
          await requestScreenTimePermission();
          isScreenTimePermissionGranted.value ? await nextPage() : (() {})();
          break;

        case 4:
          await requestBatteryOptimizationPermission();
          isBatteryOptimizationDisabled.value ? await navigate() : (() {})();
          break;

        default:
          break;
      }
    } else if (Platform.isIOS) {
      switch (rxCurrentPage.value) {
        case 0:
          await requestLocationPermission();
          isLocationPermissionGranted.value ? await nextPage() : (() {})();
          break;

        case 1:
          await requestHealthPermission();
          isHealthPermissionGranted.value ? await nextPage() : (() {})();
          break;

        case 2:
          await requestNotificationPermission();
          isNotificationPermissionGranted.value ? await navigate() : (() {})();
          break;

        default:
          break;
      }
    } else {}

    return Future<void>.value();
  }

  Future<void> nextPage() async {
    await pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    return Future<void>.value();
  }

  Future<void> navigate() async {
    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().yourDetailsScreen,
      arguments: <String, dynamic>{},
      circularTransition: true,
    );

    return Future<void>.value();
  }
}
