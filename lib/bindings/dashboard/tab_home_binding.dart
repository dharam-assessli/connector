import "package:connector/controllers/dashboard/tab_home_controller.dart";
import "package:get/get.dart";

class TabHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabHomeController>(TabHomeController());
  }
}
