import "package:connector/bindings/auth/sign_in_binding.dart";
import "package:connector/bindings/auth/verify_otp_binding.dart";
import "package:connector/bindings/connector/connector_binding.dart";
import "package:connector/bindings/dashboard/dashboard_binding.dart";
import "package:connector/bindings/dashboard/tab_chat_binding.dart";
import "package:connector/bindings/dashboard/tab_community_binding.dart";
import "package:connector/bindings/dashboard/tab_feed_binding.dart";
import "package:connector/bindings/dashboard/tab_home_binding.dart";
import "package:connector/bindings/dashboard/tab_hub_binding.dart";
import "package:connector/bindings/onboarding/gather_permissions_binding.dart";
import "package:connector/bindings/onboarding/your_details_binding.dart";
import "package:connector/bindings/splash/splash_binding.dart";
import "package:connector/bindings/unknown_route/unknown_route_binding.dart";
import "package:connector/screens/auth/sign_in_screen.dart";
import "package:connector/screens/auth/verify_otp_screen.dart";
import "package:connector/screens/connector/connector_screen.dart";
import "package:connector/screens/dashboard/dashboard_screen.dart";
import "package:connector/screens/dashboard/tab_chat_screen.dart";
import "package:connector/screens/dashboard/tab_community_screen.dart";
import "package:connector/screens/dashboard/tab_feed_screen.dart";
import "package:connector/screens/dashboard/tab_home_screen.dart";
import "package:connector/screens/dashboard/tab_hub_screen.dart";
import "package:connector/screens/onboarding/gather_permissions_screen.dart";
import "package:connector/screens/onboarding/your_details_screen.dart";
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

  String get signInScreen => "/signInScreen";
  String get verifyOTPScreen => "/verifyOTPScreen";
  String get yourDetailsScreen => "/yourDetailsScreen";

  String get dashboardScreen => "/dashboardScreen";
  String get tabHomeScreen => "/tabHomeScreen";
  String get tabFeedScreen => "/tabFeedScreen";
  String get tabChatScreen => "/tabChatScreen";
  String get tabCommunityScreen => "/tabCommunityScreen";
  String get tabHubScreen => "/tabHubScreen";

  String get connectorScreen => "/connectorScreen";
  String get gatherPermissionsScreen => "/gatherPermissionsScreen";

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
    final GetPage<dynamic> signInRoute = GetPage<dynamic>(
      name: signInScreen,
      page: SignInScreen.new,
      binding: SignInBinding(),
    );
    final GetPage<dynamic> verifyOTPRoute = GetPage<dynamic>(
      name: verifyOTPScreen,
      page: VerifyOTPScreen.new,
      binding: VerifyOTPBinding(),
    );
    final GetPage<dynamic> yourDetailsRoute = GetPage<dynamic>(
      name: yourDetailsScreen,
      page: YourDetailsScreen.new,
      binding: YourDetailsBinding(),
    );
    final GetPage<dynamic> dashboardRoute = GetPage<dynamic>(
      name: dashboardScreen,
      page: DashboardScreen.new,
      binding: DashboardBinding(),
    );
    final GetPage<dynamic> tabHomeRoute = GetPage<dynamic>(
      name: tabHomeScreen,
      page: TabHomeScreen.new,
      binding: TabHomeBinding(),
    );
    final GetPage<dynamic> tabFeedRoute = GetPage<dynamic>(
      name: tabFeedScreen,
      page: TabFeedScreen.new,
      binding: TabFeedBinding(),
    );
    final GetPage<dynamic> tabChatRoute = GetPage<dynamic>(
      name: tabChatScreen,
      page: TabChatScreen.new,
      binding: TabChatBinding(),
    );
    final GetPage<dynamic> tabCommunityRoute = GetPage<dynamic>(
      name: tabCommunityScreen,
      page: TabCommunityScreen.new,
      binding: TabCommunityBinding(),
    );
    final GetPage<dynamic> tabHubRoute = GetPage<dynamic>(
      name: tabHubScreen,
      page: TabHubScreen.new,
      binding: TabHubBinding(),
    );
    final GetPage<dynamic> connectorRoute = GetPage<dynamic>(
      name: connectorScreen,
      page: ConnectorScreen.new,
      binding: ConnectorBinding(),
    );
    final GetPage<dynamic> gatherPermissionsRoute = GetPage<dynamic>(
      name: gatherPermissionsScreen,
      page: GatherPermissionsScreen.new,
      binding: GatherPermissionsBinding(),
    );

    return <GetPage<dynamic>>[
      splashRoute,
      signInRoute,
      verifyOTPRoute,
      yourDetailsRoute,
      dashboardRoute,
      tabHomeRoute,
      tabFeedRoute,
      tabChatRoute,
      tabCommunityRoute,
      tabHubRoute,
      connectorRoute,
      gatherPermissionsRoute,
    ];
  }
}
