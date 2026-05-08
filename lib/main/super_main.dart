import "package:connector/bindings/splash/splash_binding.dart";
import "package:connector/constants/strings_constants.dart";
import "package:connector/utils/routes_utils.dart";
import "package:connector/utils/theme_data_util.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  Widget builder(BuildContext context, Widget? child) {
    final Widget newChild = child ?? const SizedBox();
    final Widget circular = CircularOverlay().wrapWithCircular(newChild);
    final Widget loader = LoaderOverlayUtil().globalLoader(child: circular);
    final Widget keyboardDismiss = KeyboardDismissUtil(child: loader);

    return keyboardDismiss;
  }
}
