import "package:connector/bindings/dashboard/tabs/tab_connector_binding.dart";
import "package:connector/bindings/dashboard/tabs/tab_profile_binding.dart";
import "package:connector/controllers/dashboard/tabs/tab_connector_controller.dart";
import "package:connector/controllers/dashboard/tabs/tab_profile_controller.dart";
import "package:connector/screens/dashboard/tabs/tab_connector_screen.dart";
import "package:connector/screens/dashboard/tabs/tab_profile_screen.dart";
import "package:connector/utils/languages_util.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";

class BottomBarUtil {
  factory BottomBarUtil() {
    return _singleton;
  }

  BottomBarUtil._internal();
  static final BottomBarUtil _singleton = BottomBarUtil._internal();

  RxList<Bindings> get getBindings {
    return <Bindings>[TabConnectorBinding(), TabProfileBinding()].obs;
  }

  RxList<GetxController> get getControllers {
    return <GetxController>[
      TabConnectorController(),
      TabProfileController(),
    ].obs;
  }

  RxList<GetView<dynamic>> get getViews {
    return <GetView<dynamic>>[
      const TabConnectorScreen(),
      const TabProfileScreen(),
    ].obs;
  }

  RxList<BottomNavigationBarItem> get tabWidgets {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: const FaIcon(FontAwesomeIcons.house, size: 24.0),
        icon: const FaIcon(FontAwesomeIcons.house, size: 24.0),
        label: LanguagesUtil().connector,
        tooltip: LanguagesUtil().connector,
      ),
      BottomNavigationBarItem(
        activeIcon: const FaIcon(FontAwesomeIcons.user, size: 24.0),
        icon: const FaIcon(FontAwesomeIcons.user, size: 24.0),
        label: LanguagesUtil().profile,
        tooltip: LanguagesUtil().profile,
      ),
    ].obs;
  }

  final RxInt rxIndex = 0.obs;

  void updateIndex(int index) {
    rxIndex.value = index;

    getBindings.elementAt(index).dependencies();

    return;
  }
}
