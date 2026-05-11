import "package:connector/controllers/dashboard/tab_community_controller.dart";
import "package:get/get.dart";

class TabCommunityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabCommunityController>(TabCommunityController());
  }
}
