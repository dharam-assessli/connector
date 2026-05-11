import "package:connector/bindings/dashboard/tab_chat_binding.dart";
import "package:connector/bindings/dashboard/tab_community_binding.dart";
import "package:connector/bindings/dashboard/tab_feed_binding.dart";
import "package:connector/bindings/dashboard/tab_home_binding.dart";
import "package:connector/bindings/dashboard/tab_hub_binding.dart";
import "package:connector/controllers/dashboard/tab_chat_controller.dart";
import "package:connector/controllers/dashboard/tab_community_controller.dart";
import "package:connector/controllers/dashboard/tab_feed_controller.dart";
import "package:connector/controllers/dashboard/tab_home_controller.dart";
import "package:connector/controllers/dashboard/tab_hub_controller.dart";
import "package:connector/screens/dashboard/tab_chat_screen.dart";
import "package:connector/screens/dashboard/tab_community_screen.dart";
import "package:connector/screens/dashboard/tab_feed_screen.dart";
import "package:connector/screens/dashboard/tab_home_screen.dart";
import "package:connector/screens/dashboard/tab_hub_screen.dart";
import "package:connector/utils/languages_util.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class BottomNavUtil {
  factory BottomNavUtil() {
    return _singleton;
  }

  BottomNavUtil._internal();
  static final BottomNavUtil _singleton = BottomNavUtil._internal();

  RxList<Bindings> get getBindings {
    return <Bindings>[
      TabHomeBinding(),
      TabFeedBinding(),
      TabChatBinding(),
      TabCommunityBinding(),
      TabHubBinding(),
    ].obs;
  }

  RxList<GetxController> get getControllers {
    return <GetxController>[
      TabHomeController(),
      TabFeedController(),
      TabChatController(),
      TabCommunityController(),
      TabHubController(),
    ].obs;
  }

  RxList<GetView<dynamic>> get getViews {
    return <GetView<dynamic>>[
      const TabHomeScreen(),
      const TabFeedScreen(),
      const TabChatScreen(),
      const TabCommunityScreen(),
      const TabHubScreen(),
    ].obs;
  }

  RxList<BottomNavigationBarItem> get tabWidgets {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.home, size: 24.0),
        icon: const Icon(Icons.home_outlined, size: 24.0),
        label: LanguagesUtil().tabHome,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.feed, size: 24.0),
        icon: const Icon(Icons.feed_outlined, size: 24.0),
        label: LanguagesUtil().tabFeed,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.mic, size: 24.0),
        icon: const Icon(Icons.mic_none_outlined, size: 24.0),
        label: LanguagesUtil().tabVoice,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.people, size: 24.0),
        icon: const Icon(Icons.people_outline, size: 24.0),
        label: LanguagesUtil().tabCommunity,
      ),
      BottomNavigationBarItem(
        activeIcon: const Icon(Icons.hub, size: 24.0),
        icon: const Icon(Icons.hub_outlined, size: 24.0),
        label: LanguagesUtil().tabHub,
      ),
    ].obs;
  }

  final RxInt rxIndex = 0.obs;

  void updateIndex(int index) {
    rxIndex.value = index;

    getBindings[index].dependencies();

    return;
  }
}
