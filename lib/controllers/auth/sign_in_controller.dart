import "package:connector/utils/routes_utils.dart";
import "package:get/get.dart";
import "package:horizon/services/jwt/auth_refresh_service.dart";
import "package:horizon/services/navigation_service.dart";

class SignInController extends GetxController {
  Future<void> handlerGoogle() async {
    await AuthRefreshService().google(navigate: navigate);

    return Future<void>.value();
  }

  Future<void> handlerApple() async {
    await AuthRefreshService().apple(navigate: navigate);

    return Future<void>.value();
  }

  Future<void> navigate() async {
    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().introductionScreen,
      arguments: <String, dynamic>{},
      circularTransition: true,
    );

    return Future<void>.value();
  }
}
