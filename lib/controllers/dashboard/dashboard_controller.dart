import "dart:developer";

import "package:connector/utils/bottom_nav_util.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:horizon/functions/mood_functions.dart";
import "package:horizon/models/draggable_scrollable_sheet/insights_model.dart";
import "package:horizon/models/draggable_scrollable_sheet/quick_start_model.dart";
import "package:horizon/services/jwt/auth_db_service.dart";

class DashboardController extends GetxController {
  final PageController pageController = PageController();

  final RxList<Bindings> getBindings = BottomNavUtil().getBindings;
  final RxList<GetxController> getControllers = BottomNavUtil().getControllers;
  final RxList<GetView<dynamic>> getViews = BottomNavUtil().getViews;
  final RxList<BottomNavigationBarItem> tabWidgets = BottomNavUtil().tabWidgets;
  final RxInt rxIndex = BottomNavUtil().rxIndex;

  final Rx<Mood> rxMood = Mood.sunny.obs;
  final Rx<num> rxSelectedMoodIndex = 0.obs;

  final RxList<QuickStartModelOuter> rxQuickStart = quickStartData.obs;
  final Rx<num> rxSelectedQuickStartIndex = 0.obs;

  final RxList<InsightsModel> rxInsights = insightsData.obs;

  @override
  void onInit() {
    super.onInit();

    log("DashboardController initialized");

    for (final Bindings binding in getBindings) {
      binding.dependencies();
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await updateIndex(index: 0, animate: false);
  }

  void refreshBindings() {
    getBindings
      ..clear()
      ..addAll(BottomNavUtil().getBindings)
      ..refresh();

    return;
  }

  void refreshControllers() {
    getControllers
      ..clear()
      ..addAll(BottomNavUtil().getControllers)
      ..refresh();

    return;
  }

  void refreshViews() {
    getViews
      ..clear()
      ..addAll(BottomNavUtil().getViews)
      ..refresh();

    return;
  }

  void refreshTabWidgets() {
    tabWidgets
      ..clear()
      ..addAll(BottomNavUtil().tabWidgets)
      ..refresh();

    return;
  }

  void refreshIndex() {
    rxIndex.value = BottomNavUtil().rxIndex.value;
    rxIndex.refresh();

    return;
  }

  Future<void> updateIndex({required int index, required bool animate}) async {
    rxIndex.value = index;

    BottomNavUtil().updateIndex(index);

    if (animate) {
      pageController.hasClients ? pageController.jumpToPage(index) : (() {})();
    } else {}

    return Future<void>.value();
  }

  String get firstName {
    return AuthDBService().user.firstName ?? "";
  }
}
