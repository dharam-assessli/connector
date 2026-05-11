import "package:connector/models/dashboard/insights/insights_model.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/builders/custom_list_view.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/gradient/custom_gradient_text.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class InsightsWidget extends StatelessWidget {
  const InsightsWidget({required this.rxInsights, super.key});
  final RxList<InsightsModel> rxInsights;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          headingWidget(context),
          const SizedBox(height: 8.0),
          customListView(context),
        ],
      );
    });
  }

  Widget headingWidget(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomText(
        data: "Insights for today",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget customListView(BuildContext context) {
    return CustomListView<InsightsModel>(
      // ignore: invalid_use_of_protected_member
      items: rxInsights.value,
      itemBuilder: itemBuilder,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget itemBuilder(BuildContext context, int index, InsightsModel item) {
    final bool is1st = index == 0;
    final bool isNth = index == rxInsights.length - 1;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: kToolbarHeight * 3,
        maxHeight: kToolbarHeight * 3,
        minWidth: kToolbarHeight * 3,
        maxWidth: kToolbarHeight * 3,
      ),
      child: CustomContainer(
        margin: EdgeInsets.only(
          left: is1st ? 8.0 : 4.0,
          right: isNth ? 8.0 : 4.0,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: CustomGradientText(
                animation: false,
                data: item.value.toString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: CustomText(
                data: item.label,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
