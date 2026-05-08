import "package:connector/controllers/unknown_route/unknown_route_controller.dart";
import "package:get/get.dart";

class UnknownRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UnknownRouteController>(UnknownRouteController());
  }
}
