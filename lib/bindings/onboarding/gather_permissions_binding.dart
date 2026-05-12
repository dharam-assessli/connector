import "package:connector/controllers/onboarding/gather_permissions_controller.dart";
import "package:get/get.dart";

class GatherPermissionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GatherPermissionsController>(GatherPermissionsController());
  }
}
