import "package:get/get.dart";
import "package:horizon/models/home/bucket_model.dart";
import "package:horizon/models/home/chart_message_model.dart";
import "package:horizon/models/home/chart_model.dart";
import "package:horizon/models/home/home_card_model.dart";
import "package:horizon/widgets/home/maps/maps_widget.dart";

class TabHomeController extends GetxController {
  final RxList<HomeCardModel> rxList = cards.obs;

  final Rx<ChartModel> rxChartData = sampleChartData.obs;

  final RxList<BucketModel> rxBucketList = sampleBucketList.obs;

  final Rx<RichMessage> rxRichMessage = RichMessage.fromJson(sampleData).obs;

  final RxList<String> rxOrder = <String>[
    "wellbeing",
    "scout",
    "community",
    "medview",
    "calendar",
    "finance",
  ].obs;

  final Rx<MapStyle> rxMapStyle = MapStyle.dark.obs;

  void reorder(int oldIndex, int newIndex) {
    // ignore: invalid_use_of_protected_member
    final String item = rxOrder.value.removeAt(oldIndex);

    // ignore: invalid_use_of_protected_member
    rxOrder.value.insert(newIndex, item);

    rxOrder.refresh();

    return;
  }
}
