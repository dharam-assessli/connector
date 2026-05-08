import "package:connector/controllers/auth/sign_in_controller.dart";
import "package:get/get.dart";

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(SignInController());
  }
}
