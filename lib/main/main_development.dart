import "dart:async";
import "dart:ui";

import "package:connector/functions/environment_functions.dart";
import "package:connector/functions/firebase_functions.dart";
import "package:connector/main/super_main.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:horizon/services/device_info_service.dart";
import "package:horizon/services/languages_service.dart";
import "package:horizon/services/notification_service.dart";
import "package:horizon/services/package_info_service.dart";
import "package:horizon/services/storage_service.dart";
import "package:horizon/services/work_manager_service.dart";
import "package:horizon/utils/orientations_util.dart";
import "package:material_ui/material_ui.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await OrientationsUtil().setPreferredOrientations(); // ← move to top

  setEnvironmentConfig();

  await initCore();
  await initCrashlytics();
  await initRemoteConfig();

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

  runApp(const MyApp());
}
