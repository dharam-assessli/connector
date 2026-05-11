import "dart:io";

import "package:connector/constants/images_constants.dart";
import "package:connector/constants/strings_constants.dart";
import "package:connector/controllers/dashboard/dashboard_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:connector/utils/theme_data_util.dart";
import "package:connector/widgets/home/draggable_scrollable_sheet/custom_draggable_scrollable_sheet.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/functions/greetings_functions.dart";
import "package:horizon/services/gradient_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/builders/custom_page_view.dart";
import "package:horizon/widgets/buttons/custom_icon_button.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:pie_menu/pie_menu.dart";

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PieCanvas(child: scaffold(context));
  }

  Widget scaffold(BuildContext context) {
    final ThemeData dataLight = ThemeDataUtil().light(
      gradient: GradientService().getGradientMode,
    );

    final ThemeData dataDark = ThemeDataUtil().dark(
      gradient: GradientService().getGradientMode,
    );

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(context),
      body: AnimatedGradient(child: SafeArea(child: body(context))),
      bottomNavigationBar: bottomNavigationBar(context),
      backgroundColor: isDark
          ? dataLight.textTheme.bodyMedium?.color
          : dataDark.textTheme.bodyMedium?.color,
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return CustomAppBar(
      elevation: 0,
      title: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: CustomText(
                data: "${LanguagesUtil().hi}, ${StringsConstants().name}!",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: CustomText(
                data: getGreeting,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        leading: CustomMediaViewer(
          data: ImagesConstants().appIcon,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      onLanguageButtonPressed: () async {
        controller
          ..refreshBindings()
          ..refreshControllers()
          ..refreshViews()
          ..refreshTabWidgets()
          ..refreshIndex();
      },
      leadingActions: <Widget>[
        // Account
        CustomIconButton(
          onPressed: () async {
            final String route = RoutesUtils().yourDetailsScreen;

            await NavigationService().pushNamed(route);
          },
          data: const Icon(Icons.account_circle_outlined),
        ),
        // Connector
        CustomIconButton(
          onPressed: () async {
            final String route = RoutesUtils().connectorScreen;

            await NavigationService().pushNamed(route);
          },
          data: const Icon(Icons.link),
        ),
      ],
      trailingActions: const <SizedBox>[SizedBox(width: 8)],
    );
  }

  Widget body(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: customPageView(context)),
        Positioned.fill(child: customDraggableScrollableSheet(context)),
      ],
    );
  }

  Widget customPageView(BuildContext context) {
    return CustomPageView<GetView<dynamic>>(
      pageController: controller.pageController,
      items: controller.getViews,
      itemBuilder: (BuildContext context, int index, GetView<dynamic> item) {
        return item;
      },
      onPageChanged: (int index) async {
        await controller.updateIndex(index: index, animate: false);
      },
    );
  }

  Widget customDraggableScrollableSheet(BuildContext context) {
    return CustomDraggableScrollableSheet(
      rxMood: controller.rxMood,
      rxSelectedMoodIndex: controller.rxSelectedMoodIndex,
      onMoodChanged: (num value) async {
        controller.rxSelectedMoodIndex.value = value;
      },
      rxQuickStart: controller.rxQuickStart,
      rxSelectedQuickStartIndex: controller.rxSelectedQuickStartIndex,
      onQuickStartChanged: (num value) async {
        controller.rxSelectedQuickStartIndex.value = value;
      },
      rxInsights: controller.rxInsights,
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Obx(() {
      return CustomContainer(
        borderRadius: BorderRadius.circular(100),
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.only(
          bottom: Platform.isAndroid
              ? kBottomNavigationBarHeight + 8
              : Platform.isIOS
              ? kBottomNavigationBarHeight - 32
              : 0,
          left: 8,
          right: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(controller.tabWidgets.length, (
            int index,
          ) {
            final InkWell child = InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                await controller.updateIndex(index: index, animate: true);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 8),
                  controller.tabWidgets[index].icon,
                  CustomText(
                    data: controller.tabWidgets[index].label ?? "",
                    style: const TextStyle(fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );

            final StatelessWidget menu = index == 2
                ? PieMenu(
                    theme: PieTheme(brightness: ThemeDataUtil().brightness),
                    onPressed: () {},
                    actions: <PieAction>[
                      PieAction(
                        tooltip: const SizedBox(),
                        onSelect: () {},
                        child: const Icon(Icons.camera),
                      ),
                    ],
                    child: child,
                  )
                : child;

            return Expanded(
              child: controller.rxIndex.value == index
                  ? CustomContainer(
                      borderRadius: BorderRadius.circular(100),
                      child: menu,
                    )
                  : menu,
            );
          }),
        ),
      );
    });
  }
}
