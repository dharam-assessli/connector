import "package:connector/constants/images_constants.dart";
import "package:connector/controllers/dashboard/dashboard_controller.dart";
import "package:connector/utils/bottom_nav_bg_selector.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:connector/utils/theme_data_util.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/functions/greetings_functions.dart";
import "package:horizon/services/gradient_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/buttons/custom_icon_button.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/draggable_scrollable_sheet/custom_draggable_scrollable_sheet.dart";
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
      body: Obx(() {
        return AnimatedGradient(
          type: BottomNavBgSelector().type,
          child: SafeArea(child: body(context)),
        );
      }),
      // bottomNavigationBar: SafeArea(child: bottomNavigationBar(context)),
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
                data: "${LanguagesUtil().hi} ${controller.firstName}",
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
      trailingActions: <Widget>[
        CustomIconButton(
          onPressed: () async {
            final String route = RoutesUtils().settingsScreen;

            final Map<String, dynamic> arguments = <String, dynamic>{};

            await NavigationService().pushNamed(route, arguments: arguments);
          },
          data: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }

  Widget body(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: customPageView(context)),

        //
        // Only show on Home tab
        if (controller.rxIndex.value == 0)
          Positioned.fill(
            child: CustomDraggableScrollableSheet(
              rxMood: controller.rxMood,
              rxSelectedMoodIndex: controller.rxSelectedMoodIndex,
              onMoodChanged: (num value) async {
                controller.rxSelectedMoodIndex.value = value;
                controller.rxSelectedMoodIndex.refresh();
              },
              rxQuickStart: controller.rxQuickStart,
              rxSelectedQuickStartIndex: controller.rxSelectedQuickStartIndex,
              onQuickStartChanged: (num value) async {
                controller.rxSelectedQuickStartIndex.value = value;
                controller.rxSelectedQuickStartIndex.refresh();
              },
              rxInsights: controller.rxInsights,
            ),
          ),
      ],
    );
  }

  // Old
  // Widget customPageView(BuildContext context) {
  //   return CustomPageView<GetView<dynamic>>(
  //     pageController: controller.pageController,
  //     items: controller.getViews,
  //     itemBuilder: (BuildContext context, int index, GetView<dynamic> item) {
  //       return item;
  //     },
  //     onPageChanged: (int index) async {
  //       await controller.updateIndex(index: index, animate: false);
  //     },
  //   );
  // }

  // New
  Widget customPageView(BuildContext context) {
    return Obx(() {
      return IndexedStack(
        index: controller.rxIndex.value,
        children: controller.getViews,
      );
    });
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Obx(() {
      return Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            child: CustomContainer(
              borderRadius: BorderRadius.circular(100),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Visibility(
                          visible: controller.rxIndex.value != index,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: controller.tabWidgets[index].icon,
                        ),
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
                          theme: PieTheme(
                            brightness: ThemeDataUtil().brightness,
                          ),
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
                    child: controller.rxIndex.value == index ? menu : menu,
                  );
                }),
              ),
            ),
          ),

          Positioned(
            top: -8,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(controller.tabWidgets.length, (
                int index,
              ) {
                final bool isSelected = controller.rxIndex.value == index;

                return Expanded(
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 320),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.4),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                      child: isSelected
                          ? Card.outlined(
                              key: ValueKey<int>(index),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: OvalBorder(
                                side: BorderSide(
                                  color: Theme.of(context).hintColor,
                                  width: 0,
                                ),
                              ),
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: controller.tabWidgets[index].icon,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
