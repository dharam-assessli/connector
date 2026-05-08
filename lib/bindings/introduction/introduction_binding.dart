import "package:connector/controllers/introduction/introduction_controller.dart";
import "package:get/get.dart";

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IntroductionController>(IntroductionController());
  }
}
