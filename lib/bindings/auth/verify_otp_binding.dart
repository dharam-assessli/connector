import "package:connector/controllers/auth/verify_otp_controller.dart";
import "package:get/get.dart";

class VerifyOTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VerifyOTPController>(VerifyOTPController());
  }
}
