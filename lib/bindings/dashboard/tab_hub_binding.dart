import "package:connector/controllers/dashboard/tab_hub_controller.dart";
import "package:get/get.dart";

class TabHubBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabHubController>(TabHubController());
  }
}
