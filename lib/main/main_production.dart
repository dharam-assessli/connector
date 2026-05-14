import "dart:async";
import "dart:developer";
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
  WidgetsFlutterBinding.ensureInitialized();

  DartPluginRegistrant.ensureInitialized();

  await OrientationsUtil().setPreferredOrientations();

  setEnvironmentConfig();

  await initCore();

  await StorageService().init();

  await LanguagesService().init(usePackagesHorizon: true);
  await LanguagesService().init(usePackagesHorizon: false);

  await PackageInfoService().init();

  runApp(const MyApp());

  unawaited(deferredInitialization());
}

Future<void> deferredInitialization() async {
  try {
    await initCrashlytics();

    await initRemoteConfig();

    await DeviceInfoService().init();

    // NotificationService: startPlugin in deferred initialization
    await NotificationService().startPlugin();

    // WorkManager: configureBundleID must complete before initialize/registerTasks
    await WorkManagerService().configureBundleID();
    await WorkManagerService().initialize();
    await WorkManagerService().registerTasks();
  } on Exception catch (error, stackTrace) {
    log("Exception", error: error, stackTrace: stackTrace);
  } finally {}

  return Future<void>.value();
}
