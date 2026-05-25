import "package:connector/controllers/sync/manual_sync_controller.dart";
import "package:get/get.dart";

class ManualSyncBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ManualSyncController>(ManualSyncController());
  }
}
