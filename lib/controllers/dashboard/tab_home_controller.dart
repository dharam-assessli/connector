import "package:carousel_slider/carousel_slider.dart";
import "package:connector/models/dashboard/chart/bucket_model.dart";
import "package:connector/models/dashboard/chart/chart_model.dart";
import "package:connector/models/dashboard/chart/rich_segment_model.dart";
import "package:connector/widgets/home/maps/maps_widget.dart";
import "package:get/get.dart";

class TabHomeController extends GetxController {
  final CarouselSliderController sliderController = CarouselSliderController();

  final Rx<ChartModel> rxChartData = sampleChartData.obs;

  final Rx<RichMessage> rxRichMessage = RichMessage(
    segments: <RichSegmentModel>[],
  ).obs;

  final RxList<BucketModel> rxBucketList = <BucketModel>[].obs;

  final Rx<MapStyle> rxMapStyle = MapStyle.dark.obs;

  // Reorderable GridView order list
  final RxList<String> rxOrder = <String>[
    "wellbeing",
    "scout",
    "community",
    "medview",
    "calendar",
    "finance",
  ].obs;

  @override
  void onInit() {
    super.onInit();

    initRichMessage();

    initBucketList();
  }

  void initRichMessage() {
    rxRichMessage.value = RichMessage.fromJson(sampleData);

    return;
  }

  void initBucketList() {
    rxBucketList.value = sampleBucketList;

    return;
  }

  // Reorder function for the shortcut grid.
  void reorder(int oldIndex, int newIndex) {
    // ignore: invalid_use_of_protected_member
    final String item = rxOrder.value.removeAt(oldIndex);

    // ignore: invalid_use_of_protected_member
    rxOrder.value.insert(newIndex, item);

    rxOrder.refresh();

    return;
  }
}
