import "dart:async";

import "package:connector/bindings/splash/splash_binding.dart";
import "package:connector/constants/colors_constants.dart";
import "package:connector/constants/strings_constants.dart";
import "package:connector/utils/routes_utils.dart";
import "package:connector/utils/theme_data_util.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";
import "package:horizon/observer/observer.dart";
import "package:horizon/services/languages_service.dart";
import "package:horizon/utils/bottom_sheets/gradient_sheet.dart";
import "package:horizon/utils/bottom_sheets/language_sheet.dart";
import "package:horizon/utils/bottom_sheets/theme_sheet.dart";
import "package:horizon/utils/custom_listenable.dart";
import "package:horizon/utils/keyboard_dismiss_util.dart";
import "package:horizon/utils/overlays/circular_overlay.dart";
import "package:horizon/utils/overlays/loader_overlay_util.dart";
import "package:overlay_support/overlay_support.dart";

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((Duration duration) async {
      await applySystemUI();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      await applySystemUI();
    }
  }

  @override
  Widget build(final BuildContext context) {
    return CustomListenable().multiValueListenableBuilder(
      <ValueListenable<dynamic>>[
        selectedLocale,
        selectedTheme,
        selectedGradient,
      ],
      mainWidget,
      null,
    );
  }

  Widget mainWidget(BuildContext p0, List<dynamic> p1, Widget? p2) {
    final Locale locale = p1[0] as Locale;
    final ThemeMode themeMode = p1[1] as ThemeMode;
    final List<int> gradient = p1[2] as List<int>;

    return GetMaterialApp(
      title: StringsConstants().appName,
      navigatorKey: Get.key,
      navigatorObservers: <NavigatorObserver>[Observer()],
      getPages: RoutesUtils().getPages,
      initialRoute: RoutesUtils().splashScreen,
      initialBinding: SplashBinding(),
      unknownRoute: RoutesUtils().getUnknownPage,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData media = MediaQuery.of(context);

        return MediaQuery(
          data: media.copyWith(textScaler: TextScaler.noScaling),
          child: Overlay(
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (BuildContext context) {
                  return builder(context, child);
                },
              ),
            ],
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeDataUtil().dark(gradient: gradient),
      darkTheme: ThemeDataUtil().dark(gradient: gradient),
      translations: LanguagesService(),
      locale: locale,
      supportedLocales: LanguagesService().supportedLocales,
      fallbackLocale: LanguagesService().fallbackLocale,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      enableLog: false,
    );
  }

  // Builder for overlapping widgets like loaders, snack bars, etc.
  Widget builder(BuildContext context, Widget? child) {
    final Widget app = child ?? const SizedBox();

    return OverlaySupport.global(
      child: LoaderOverlayUtil().globalLoader(
        child: KeyboardDismissUtil(
          child: CircularOverlay().wrapWithCircular(app),
        ),
      ),
    );
  }

  Future<void> applySystemUI() async {
    final ThemeMode themeMode = selectedTheme.value;

    final bool isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorsConstants().transparent,
        systemStatusBarContrastEnforced: false,

        systemNavigationBarColor: ColorsConstants().transparent,
        systemNavigationBarContrastEnforced: false,

        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return Future<void>.value();
  }
}
