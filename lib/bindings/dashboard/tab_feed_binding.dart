import "package:connector/controllers/dashboard/tab_feed_controller.dart";
import "package:get/get.dart";

class TabFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabFeedController>(TabFeedController());
  }
}
