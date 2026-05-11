import "package:connector/controllers/dashboard/tab_home_controller.dart";
import "package:connector/widgets/home/carousel_slider/home_carousel_slider.dart";
import "package:connector/widgets/home/chart/bucket_sheet.dart";
import "package:connector/widgets/home/chart/chart_annotations.dart";
import "package:connector/widgets/home/chart/rich_message_text.dart";
import "package:connector/widgets/home/chart/scrollable_hourly_chart.dart";
import "package:connector/widgets/home/image/home_human_image_widget.dart";
import "package:connector/widgets/home/maps/maps_widget.dart";
import "package:connector/widgets/home/note/ai_note_widget.dart";
import "package:connector/widgets/home/shortcut_grid/shortcut_grid.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class TabHomeScreen extends GetView<TabHomeController> {
  const TabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: kToolbarHeight * 9.56,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: HomeHumanImageWidget(),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: HomeCarouselSlider(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          ChartAnnotations(bucketList: controller.rxBucketList),
          const SizedBox(height: 16),

          ScrollableHourlyChart(rxChartData: controller.rxChartData),
          const SizedBox(height: 16),

          RichMessageText(
            richMessage: controller.rxRichMessage.value,
            onTap: () async {
              await showBucketSheet(bucketList: controller.rxBucketList);
            },
          ),
          const SizedBox(height: 16),

          const AINoteWidget(),
          const SizedBox(height: 16),

          ShortcutGrid(
            rxOrder: controller.rxOrder,
            onReorder: controller.reorder,
          ),
          const SizedBox(height: 16),

          MapsWidget(
            rxMapStyle: controller.rxMapStyle,
            onTap: () async {
              final MapStyle result = await showMapStyleSheet(
                currentStyle: controller.rxMapStyle.value,
              );

              controller.rxMapStyle.value = result;
            },
          ),
          const SizedBox(height: kToolbarHeight - 16),
        ],
      ),
    );
  }
}
