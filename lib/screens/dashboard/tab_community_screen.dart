import "package:connector/controllers/dashboard/tab_community_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/builders/custom_future_builder.dart";
import "package:webview_flutter/webview_flutter.dart";

class TabCommunityScreen extends GetView<TabCommunityController> {
  const TabCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(child: customFutureBuilder()),
        const SizedBox(height: kToolbarHeight - 16),
      ],
    );
  }

  Widget customFutureBuilder() {
    return CustomFutureBuilder<WebViewController>(
      future: controller.future,
      builder: (BuildContext context, WebViewController? value) {
        return value != null
            ? WebViewWidget(controller: value)
            : const SizedBox();
      },
    );
  }
}
