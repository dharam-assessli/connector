import "dart:async";
import "dart:ui";

import "package:connector/functions/environment_functions.dart";
import "package:connector/functions/firebase_functions.dart";
import "package:connector/main/super_main.dart";
import "package:horizon/services/device_info_service.dart";
import "package:horizon/services/languages_service.dart";
import "package:horizon/services/notification_service.dart";
import "package:horizon/services/package_info_service.dart";
import "package:horizon/services/storage_service.dart";
import "package:horizon/services/work_manager_service.dart";
import "package:horizon/utils/orientations_util.dart";
import "package:material_ui/material_ui.dart";

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure plugins are registered
  DartPluginRegistrant.ensureInitialized();

  await OrientationsUtil().setPreferredOrientations();

  setEnvironmentConfig();

  await initCore();
  await initCrashlytics();
  await initRemoteConfig();

  await StorageService().init();

  await LanguagesService().init(usePackagesHorizon: true);
  await LanguagesService().init(usePackagesHorizon: false);

  await PackageInfoService().init();

  await DeviceInfoService().init();

  await NotificationService().initialize();

  await WorkManagerService().configureBundleID();
  await WorkManagerService().initialize();
  await WorkManagerService().registerTasks();

  runApp(const MyApp());
}
