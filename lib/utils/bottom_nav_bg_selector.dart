// import "package:dotsin/controllers/dashboard/tab_chat_controller.dart";
// import "package:dotsin/controllers/dashboard/tab_community_controller.dart";
// import "package:dotsin/controllers/dashboard/tab_days_controller.dart";
// import "package:dotsin/controllers/dashboard/tab_feed_controller.dart";
// import "package:dotsin/controllers/dashboard/tab_home_controller.dart";
// import "package:dotsin/controllers/dashboard/tab_hub_controller.dart";
import "package:connector/utils/bottom_nav_util.dart";
// import "package:get/get.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";

class BottomNavBgSelector {
  factory BottomNavBgSelector() {
    return _singleton;
  }

  BottomNavBgSelector._internal();
  static final BottomNavBgSelector _singleton = BottomNavBgSelector._internal();

  AnimatedGradientType get type {
    // final TabHomeController tab1 = Get.find<TabHomeController>();
    // final TabFeedController tab2 = Get.find<TabFeedController>();
    // final TabChatController tab3 = Get.find<TabChatController>();
    // final TabCommunityController tab4 = Get.find<TabCommunityController>();
    // final TabHubController tab5 = Get.find<TabHubController>();
    // final TabDaysController tab6 = Get.find<TabDaysController>();

    switch (BottomNavUtil().rxIndex.value) {
      case 0:
        return AnimatedGradientType.main;
      case 1:
        return AnimatedGradientType.main;
      case 2:
        return AnimatedGradientType.main;
      case 3:
        return AnimatedGradientType.main;
      case 4:
        return AnimatedGradientType.main;
      default:
        return AnimatedGradientType.main;
    }
  }
}
