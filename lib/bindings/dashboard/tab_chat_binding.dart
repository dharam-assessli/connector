import "package:connector/controllers/dashboard/tab_chat_controller.dart";
import "package:get/get.dart";

class TabChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TabChatController>(TabChatController());
  }
}
