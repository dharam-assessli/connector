import "package:connector/firebase_options/firebase_options_development.dart"
    as development;
import "package:connector/firebase_options/firebase_options_production.dart"
    as production;
import "package:connector/firebase_options/firebase_options_staging.dart"
    as staging;
import "package:connector/flavor/flavor.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";
import "package:horizon/services/crashlytics_service.dart";
import "package:horizon/services/firebase_core_service.dart";
import "package:horizon/services/remote_config_service.dart";

Future<void> initCore() async {
  FirebaseOptions? options;

  switch (Flavor().getFlavor) {
    case FlavorsEnum.development:
      options = development.DefaultFirebaseOptions.currentPlatform;
      break;

    case FlavorsEnum.staging:
      options = staging.DefaultFirebaseOptions.currentPlatform;
      break;

    case FlavorsEnum.production:
      options = production.DefaultFirebaseOptions.currentPlatform;
      break;

    case FlavorsEnum.unknown:
      break;
  }

  if (options != null) {
    await FirebaseCoreService().initializeApp(options);
  } else {}

  return Future<void>.value();
}

Future<void> initCrashlytics() async {
  FlutterError.onError = CrashlyticsService().recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    return CrashlyticsService().recordError(error, stack);
  };

  return Future<void>.value();
}

Future<void> initRemoteConfig() async {
  await RemoteConfigService().initialize();

  return Future<void>.value();
}
