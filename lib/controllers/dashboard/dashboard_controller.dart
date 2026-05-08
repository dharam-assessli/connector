import "dart:developer";

import "package:connector/utils/bottom_bar_util.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";

class DashboardController extends GetxController {
  final PageController pageController = PageController();

  final RxList<Bindings> getBindings = BottomBarUtil().getBindings;
  final RxList<GetxController> getControllers = BottomBarUtil().getControllers;
  final RxList<GetView<dynamic>> getViews = BottomBarUtil().getViews;
  final RxList<BottomNavigationBarItem> tabWidgets = BottomBarUtil().tabWidgets;

  final RxInt rxIndex = BottomBarUtil().rxIndex;

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
      ..addAll(BottomBarUtil().getBindings)
      ..refresh();

    return;
  }

  void refreshControllers() {
    getControllers
      ..clear()
      ..addAll(BottomBarUtil().getControllers)
      ..refresh();

    return;
  }

  void refreshViews() {
    getViews
      ..clear()
      ..addAll(BottomBarUtil().getViews)
      ..refresh();

    return;
  }

  void refreshTabWidgets() {
    tabWidgets
      ..clear()
      ..addAll(BottomBarUtil().tabWidgets)
      ..refresh();

    return;
  }

  void refreshIndex() {
    rxIndex.value = BottomBarUtil().rxIndex.value;

    rxIndex.refresh();

    return;
  }

  Future<void> updateIndex({required int index, required bool animate}) async {
    rxIndex.value = index;

    BottomBarUtil().updateIndex(index);

    if (animate) {
      await pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.linear,
      );
    } else {}

    return Future<void>.value();
  }
}
