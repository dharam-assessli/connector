import "package:connector/controllers/onboarding/your_details_controller.dart";
import "package:get/get.dart";

class YourDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<YourDetailsController>(YourDetailsController());
  }
}
