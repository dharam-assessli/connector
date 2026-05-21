import "package:connector/controllers/dashboard/tab_home_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class TabHomeScreen extends GetView<TabHomeController> {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[SizedBox(height: kToolbarHeight - 16)],
      ),
    );
  }
}
