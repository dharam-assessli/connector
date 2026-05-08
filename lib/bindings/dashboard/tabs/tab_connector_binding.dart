import "package:connector/controllers/dashboard/tabs/tab_connector_controller.dart";
import "package:get/get.dart";

class TabConnectorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabConnectorController>(TabConnectorController());
  }
}
