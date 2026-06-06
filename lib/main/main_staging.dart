import "dart:async";
import "dart:developer";
import "dart:ui";

import "package:connector/functions/environment_functions.dart";
import "package:connector/functions/firebase_functions.dart";
import "package:connector/main/super_main.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/services.dart";
import "package:horizon/services/device_info_service.dart";
import "package:horizon/services/languages_service.dart";
// import "package:horizon/services/location_service.dart";
import "package:horizon/services/location_service_2.dart";
import "package:horizon/services/notification_service.dart";
import "package:horizon/services/package_info_service.dart";
import "package:horizon/services/storage_service.dart";
import "package:horizon/services/work_manager_service.dart";
import "package:horizon/utils/orientations_util.dart";
import "package:material_ui/material_ui.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DartPluginRegistrant.ensureInitialized();

  await OrientationsUtil().setPreferredOrientations();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  setEnvironmentConfig();

  const Duration timeout = Duration(seconds: 5);
  await initFirebaseCore().timeout(
    timeout,
    onTimeout: () => log("initFirebaseCore() timeout"),
  );
  await initFirebaseCrashlytics().timeout(
    timeout,
    onTimeout: () => log("initFirebaseCrashlytics() timeout"),
  );
  await initFirebaseRemoteConfig().timeout(
    timeout,
    onTimeout: () => log("initFirebaseRemoteConfig() timeout"),
  );

  await StorageService().init();
  await PackageInfoService().init();

  await DeviceInfoService().init();

  await LanguagesService().init(usePackagesHorizon: true);
  await LanguagesService().init(usePackagesHorizon: false);

  await NotificationService().initialize();

  FirebaseMessaging.onMessage.listen(foregroundHandler);

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await WorkManagerService().configureBundleID();
  await WorkManagerService().initialize();
  await WorkManagerService().registerTasks();

  // await LocationService().getPositionStream();
  await LocationService2().enableBackgroundMode();
  // await LocationService2().getPositionStream();

  runApp(const MyApp());
}
