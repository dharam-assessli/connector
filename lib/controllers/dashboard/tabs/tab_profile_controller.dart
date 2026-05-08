import "package:connector/utils/routes_utils.dart";
import "package:get/get.dart";
import "package:horizon/models/auth/auth.dart";
import "package:horizon/repositories/auth/auth_repository.dart";
import "package:horizon/services/jwt/auth_db_service.dart";
import "package:horizon/services/navigation_service.dart";

class TabProfileController extends GetxController {
  final Rx<User> rxUser = AuthDBService().user.obs;

  String get contructImageURL {
    final String displayName = rxUser.value.displayName ?? "";

    return "https://ui-avatars.com/api/?name=$displayName";
  }

  Future<void> onSignOutTap() async {
    // Need to add actual API
    await AuthRepository().signOut();

    await AuthDBService().removeAuth();

    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().signInScreen,
    );

    return Future<void>.value();
  }
}
