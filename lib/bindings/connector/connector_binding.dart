import "package:connector/controllers/connector/connector_controller.dart";
import "package:get/get.dart";

class ConnectorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectorController>(ConnectorController());
  }
}
