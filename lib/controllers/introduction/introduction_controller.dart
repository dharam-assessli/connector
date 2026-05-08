import "dart:io";

import "package:connector/models/introduction/introduction_model.dart";
import "package:connector/utils/routes_utils.dart";
import "package:get/get.dart";
import "package:horizon/services/navigation_service.dart";
import "package:material_ui/material_ui.dart";

class IntroductionController extends GetxController {
  final RxList<IntroductionModel> rxSlides = <IntroductionModel>[].obs;

  final PageController pageController = PageController();
  final RxInt rxCurrentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();

    initialize();
  }

  void initialize() {
    rxSlides.clear();

    // ignore: invalid_use_of_protected_member
    rxSlides.value.addAll(
      Platform.isAndroid
          ? <IntroductionModel>[
              introLocation,
              introHealth,
              introScreen,
              introNotification,
            ]
          : Platform.isIOS
          ? <IntroductionModel>[introLocation, introHealth, introNotification]
          : <IntroductionModel>[],
    );

    rxSlides.refresh();

    return;
  }

  Future<void> animateToPage({required final int index}) async {
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.linear,
    );

    return Future<void>.value();
  }

  Future<void> updateCurrentPage({required final int index}) async {
    rxCurrentPage.value = index;

    return Future<void>.value();
  }

  Future<void> navigate() async {
    await NavigationService().pushNamedAndRemoveUntil(
      RoutesUtils().dashboardScreen,
      arguments: <String, dynamic>{},
      circularTransition: true,
    );

    return Future<void>.value();
  }
}
