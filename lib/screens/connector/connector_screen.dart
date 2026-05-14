import "dart:io";

import "package:connector/controllers/connector/connector_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/widgets/category_container.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

class ConnectorScreen extends GetView<ConnectorController> {
  const ConnectorScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              introductionWidget(context),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: categoriesWidget(context),
                ),
              ),
              const SizedBox(height: 16),
              Align(child: batteryOptimizationWidget()),
              const SizedBox(height: 16),
              Align(child: infoText()),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget introductionWidget(final BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            data: LanguagesUtil().connectorHeading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          CustomText(
            data: LanguagesUtil().connectorTopDescription,
            style: const TextStyle(fontSize: 14),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          CustomText(
            data: LanguagesUtil().connectorBtmDescription,
            style: const TextStyle(fontSize: 12),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget categoriesWidget(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CategoryContainer(
                icon: const FaIcon(FontAwesomeIcons.mapLocationDot, size: 56.0),
                heading: LanguagesUtil().location,
                onItemTap: controller.onItemTapLocation,
                onHelpTap: controller.onHelpTapLocation,
                onSettingsTap: controller.onSettingsTapLocation,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CategoryContainer(
                icon: const FaIcon(FontAwesomeIcons.heartPulse, size: 56.0),
                heading: LanguagesUtil().health,
                onItemTap: controller.onItemTapHealth,
                onHelpTap: controller.onHelpTapHealth,
                onSettingsTap: controller.onSettingsTapTapHealth,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CategoryContainer(
                icon: const FaIcon(FontAwesomeIcons.bell, size: 56.0),
                heading: LanguagesUtil().notifications,
                onItemTap: controller.onItemTapNotification,
                onHelpTap: controller.onHelpTapNotification,
                onSettingsTap: controller.onSettingsTapNotification,
              ),
            ),
            if (Platform.isAndroid) const SizedBox(width: 16),
            if (Platform.isAndroid)
              Expanded(
                child: CategoryContainer(
                  icon: const FaIcon(FontAwesomeIcons.chartColumn, size: 56.0),
                  heading: LanguagesUtil().screenTime,
                  onItemTap: controller.onItemTapScreenTime,
                  onHelpTap: controller.onHelpTapScreenTime,
                  onSettingsTap: controller.onSettingsTapScreenTime,
                ),
              )
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget batteryOptimizationWidget() {
    final bool value = controller.rxisDisabledOptimization.value;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: CustomContainer(
            padding: const EdgeInsets.all(8),
            onTap: () async {
              final bool value = await controller.isDisabledOptimization();
              controller.rxisDisabledOptimization.value = value;
            },
            child: CustomText(
              data: "Battery optimization: ${value ? "Disabled" : "Enabled"}",
              style: const TextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(width: 8),
        CustomContainer(
          padding: const EdgeInsets.all(8),
          onTap: () async {
            await controller.openBatteryOptimizationSettings();
          },
          child: const Icon(Icons.settings_outlined, size: 24.0),
        ),
      ],
    );
  }

  Widget infoText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FaIcon(FontAwesomeIcons.circleInfo, size: 16.0),
          const SizedBox(width: 8),
          Flexible(
            child: CustomText(
              data: LanguagesUtil().reassurance,
              style: const TextStyle(fontSize: 12),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
