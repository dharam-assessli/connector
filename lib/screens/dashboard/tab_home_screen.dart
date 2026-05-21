import "package:connector/controllers/dashboard/tab_home_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/home/carousel_slider/carousel_slider.dart";
import "package:horizon/widgets/home/chart/bucket_sheet.dart";
import "package:horizon/widgets/home/chart/chart_annotations.dart";
import "package:horizon/widgets/home/chart/chart_message.dart";
import "package:horizon/widgets/home/chart/scrollable_hourly_chart.dart";
import "package:horizon/widgets/home/image/human_image_widget.dart";
import "package:horizon/widgets/home/maps/maps_widget.dart";
import "package:horizon/widgets/home/note/ai_note_widget.dart";
import "package:horizon/widgets/home/shortcut_grid/shortcut_grid.dart";
import "package:material_ui/material_ui.dart";

class TabHomeScreen extends GetView<TabHomeController> {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          stackWidget(),
          const SizedBox(height: 8.0),
          chartAnnotations(),
          const SizedBox(height: 8.0),
          scrollableHourlyChart(),
          const SizedBox(height: 8.0),
          chartMessage(),
          const SizedBox(height: 8.0),
          aiNoteWidget(),
          const SizedBox(height: 8.0),
          shortcutGrid(),
          const SizedBox(height: 8.0),
          mapsWidget(),
          const SizedBox(height: kToolbarHeight - 16),
        ],
      ),
    );
  }

  Widget stackWidget() {
    return Stack(
      children: <Widget>[
        Positioned(child: humanImageWidget()),
        Positioned(child: carouselSlider()),
      ],
    );
  }

  Widget humanImageWidget() {
    return const HumanImageWidget();
  }

  Widget carouselSlider() {
    return CarouselSlider(rxList: controller.rxList);
  }

  Widget chartAnnotations() {
    return const ChartAnnotations();
  }

  Widget scrollableHourlyChart() {
    return ScrollableHourlyChart(rxChartData: controller.rxChartData);
  }

  Widget chartMessage() {
    return ChartMessage(
      rxRichMessage: controller.rxRichMessage,
      onTap: () async {
        await showBucketSheet(bucketList: controller.rxBucketList);
      },
    );
  }

  Widget aiNoteWidget() {
    return const AINoteWidget();
  }

  Widget shortcutGrid() {
    return ShortcutGrid(
      rxOrder: controller.rxOrder,
      onReorder: controller.reorder,
    );
  }

  Widget mapsWidget() {
    return MapsWidget(
      rxMapStyle: controller.rxMapStyle,
      onTap: () async {
        final MapStyle result = await showMapStyleSheet(
          currentStyle: controller.rxMapStyle.value,
        );

        controller.rxMapStyle.value = result;
      },
    );
  }
}
