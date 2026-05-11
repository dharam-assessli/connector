import "dart:developer";

import "package:get/get.dart";
import "package:webview_flutter/webview_flutter.dart";

class TabCommunityController extends GetxController {
  late Future<WebViewController> future;

  @override
  void onInit() {
    super.onInit();

    future = loadRequest();
  }

  Future<WebViewController> loadRequest() async {
    final WebViewController controller = WebViewController();

    try {
      // Enable JavaScript
      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      // Load the initial URL
      await controller.loadRequest(Uri.parse("https://example.com"));
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<WebViewController>.value(controller);
  }
}
