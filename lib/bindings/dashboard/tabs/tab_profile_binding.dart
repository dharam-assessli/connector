import "package:connector/controllers/dashboard/tabs/tab_profile_controller.dart";
import "package:get/get.dart";

class TabProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabProfileController>(TabProfileController());
  }
}
