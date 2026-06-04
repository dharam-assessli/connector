import "dart:io";

import "package:connector/constants/strings_constants.dart";
import "package:connector/utils/bottom_nav_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:get/get.dart";
import "package:horizon/repositories/auth/auth_repository.dart";
import "package:horizon/repositories/auth/user_repository.dart";
import "package:horizon/services/jwt/auth_db_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/services/open_store_service.dart";
import "package:horizon/services/package_info_service.dart";
import "package:horizon/services/share_service.dart";
import "package:horizon/widgets/bottom_sheet/settings_sheet.dart";
import "package:uuid/uuid.dart";

class SettingsController extends GetxController {
  Future<void> deactivateAccount() async {
    BottomNavUtil().updateIndex(0);

    await UserRepository().deactivateAccount();

    await AuthDBService().removeAuth();

    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().signInScreen,
      arguments: <String, dynamic>{},
    );

    return Future<void>.value();
  }

  Future<void> deleteAccount() async {
    BottomNavUtil().updateIndex(0);

    await UserRepository().deleteAccount();

    await AuthDBService().removeAuth();

    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().signInScreen,
      arguments: <String, dynamic>{},
    );

    return Future<void>.value();
  }

  Future<void> signOut() async {
    BottomNavUtil().updateIndex(0);

    await AuthRepository().signOut(<String, dynamic>{
      "refresh_token": AuthDBService().verifyOTP.refreshToken ?? "",
    });

    await AuthDBService().removeAuth();

    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().signInScreen,
      arguments: <String, dynamic>{},
      circularTransition: true,
    );

    return Future<void>.value();
  }

  Future<void> sendFeedback(SheetType sheetType, String message) async {
    if (message.isEmpty) {
      // return if message is empty

      return Future<void>.value();
    }

    await UserRepository().feedback(<String, dynamic>{
      "content_id": const Uuid().v1(),
      "content_type": "general",
      "feedback_kind": "feedback",
      "rating": 5,
      "comment": message,
    });

    return Future<void>.value();
  }

  Future<void> openShare() async {
    final String shareMessage =
        """
Join me on Dotsin! 🚀

Dotsin helps you understand your habits, wellbeing, and daily patterns through AI-powered insights.

Download now:
Android: ${StringsConstants().storeAndroid}
iPhone: ${StringsConstants().storeiOS}
""";

    await ShareService().share(text: shareMessage);

    return Future<void>.value();
  }

  Future<void> openStore() async {
    await OpenStoreService().open(
      url: Platform.isAndroid
          ? StringsConstants().storeAndroid
          : StringsConstants().storeiOS,
    );

    return Future<void>.value();
  }

  RxString get appVersion {
    return PackageInfoService().packageInfo.version.obs;
  }
}
