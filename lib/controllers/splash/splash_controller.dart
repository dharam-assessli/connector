import "package:connector/utils/routes_utils.dart";
import "package:get/get.dart";
import "package:horizon/models/auth/user.dart";
import "package:horizon/observer/observer.dart";
import "package:horizon/services/api_gateway.dart";
import "package:horizon/services/jwt/auth_db_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/services/pre_checks_service.dart";
import "package:horizon/services/upgrade_service.dart";
import "package:horizon/services/user_agent_service.dart";
import "package:horizon/utils/countries/countries_util.dart";
import "package:material_ui/material_ui.dart";

class SplashController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    // await Future<void>.delayed(const Duration(seconds: 3));
    await procedure();
    await preChecks();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    // Only perform pre-checks when the current route is the splash screen.
    if (Observer().currentRouteName != RoutesUtils().splashScreen) {
      return Future<void>.value();
    } else {}

    // Only perform pre-checks when the app is resumed.
    if (state != AppLifecycleState.resumed) {
      return Future<void>.value();
    } else {}

    // Only perform pre-checks when the bottom sheet is not open.
    if (Get.isBottomSheetOpen ?? false) {
      return Future<void>.value();
    } else {}

    await preChecks();
  }

  Future<void> procedure() async {
    await UserAgentService().init();

    await UpgradeService().initialize();

    await CountriesUtil().loadCountries(usePackagesHorizon: true);
    // await CountriesUtil().loadCountries(usePackagesHorizon: false);

    return Future<void>.value();
  }

  Future<void> preChecks() async {
    // Set the screen that should be shown when the user is not authenticated
    APIGateway().unauthorizedScreen = RoutesUtils().signInScreen;

    // Set the function that should be executed during pre-checks
    PreChecksService().function = () async {
      final User user = AuthDBService().user;
      final bool hasUser = (user.id ?? "").isNotEmpty;
      final bool isNewUser = user.isNewUser ?? false;

      // Decide the route
      final String route = !hasUser
          ? RoutesUtils().signInScreen
          : isNewUser
          ? RoutesUtils().gatherPermissionsScreen
          : RoutesUtils().dashboardScreen;

      // Navigate to the route
      await NavigationService().pushNamedAndRemoveUntil(
        route,
        circularTransition: true,
      );
    };

    await PreChecksService().hasConnection();

    return Future<void>.value();
  }
}
