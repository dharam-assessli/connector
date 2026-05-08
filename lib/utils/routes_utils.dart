import "package:connector/bindings/auth/sign_in_binding.dart";
import "package:connector/bindings/dashboard/dashboard_binding.dart";
import "package:connector/bindings/dashboard/tabs/tab_connector_binding.dart";
import "package:connector/bindings/dashboard/tabs/tab_profile_binding.dart";
import "package:connector/bindings/introduction/introduction_binding.dart";
import "package:connector/bindings/splash/splash_binding.dart";
import "package:connector/bindings/unknown_route/unknown_route_binding.dart";
import "package:connector/screens/auth/sign_in_screen.dart";
import "package:connector/screens/dashboard/dashboard_screen.dart";
import "package:connector/screens/dashboard/tabs/tab_connector_screen.dart";
import "package:connector/screens/dashboard/tabs/tab_profile_screen.dart";
import "package:connector/screens/introduction/introduction_screen.dart";
import "package:connector/screens/splash/splash_screen.dart";
import "package:connector/screens/unknown_route/unknown_route_screen.dart";
import "package:get/get.dart";

class RoutesUtils {
  factory RoutesUtils() {
    return _singleton;
  }

  RoutesUtils._internal();
  static final RoutesUtils _singleton = RoutesUtils._internal();

  // Unknown Page
  String get unknownRouteScreen => "/unknownRouteScreen";

  // Known Pages
  String get splashScreen => "/splashScreen";
  String get introductionScreen => "/introductionScreen";
  String get signInScreen => "/signInScreen";
  String get dashboardScreen => "/dashboardScreen";
  String get tabConnectorScreen => "/tabConnectorScreen";
  String get tabProfileScreen => "/tabProfileScreen";

  // Unknown Page
  GetPage<dynamic> get getUnknownPage {
    return GetPage<dynamic>(
      name: unknownRouteScreen,
      page: UnknownRouteScreen.new,
      binding: UnknownRouteBinding(),
    );
  }

  // Known Pages
  List<GetPage<dynamic>> get getPages {
    final GetPage<dynamic> splashRoute = GetPage<dynamic>(
      name: splashScreen,
      page: SplashScreen.new,
      binding: SplashBinding(),
    );
    final GetPage<dynamic> introductionRoute = GetPage<dynamic>(
      name: introductionScreen,
      page: IntroductionScreen.new,
      binding: IntroductionBinding(),
    );
    final GetPage<dynamic> signInRoute = GetPage<dynamic>(
      name: signInScreen,
      page: SignInScreen.new,
      binding: SignInBinding(),
    );
    final GetPage<dynamic> dashboardRoute = GetPage<dynamic>(
      name: dashboardScreen,
      page: DashboardScreen.new,
      binding: DashboardBinding(),
    );
    final GetPage<dynamic> tabConnectorRoute = GetPage<dynamic>(
      name: tabConnectorScreen,
      page: TabConnectorScreen.new,
      binding: TabConnectorBinding(),
    );
    final GetPage<dynamic> tabProfileRoute = GetPage<dynamic>(
      name: tabProfileScreen,
      page: TabProfileScreen.new,
      binding: TabProfileBinding(),
    );

    return <GetPage<dynamic>>[
      splashRoute,
      introductionRoute,
      signInRoute,
      dashboardRoute,
      tabConnectorRoute,
      tabProfileRoute,
    ];
  }
}
