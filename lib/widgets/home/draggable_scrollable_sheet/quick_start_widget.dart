import "package:connector/models/dashboard/quick_start/quick_start_model.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/builders/custom_list_view.dart";
import "package:horizon/widgets/buttons/custom_elevated_button.dart";
import "package:horizon/widgets/chip/custom_chip.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class QuickStartWidget extends StatelessWidget {
  const QuickStartWidget({
    required this.rxQuickStart,
    required this.rxSelectedQuickStartIndex,
    required this.onQuickStartChanged,
    super.key,
  });
  final RxList<QuickStartModelOuter> rxQuickStart;
  final Rx<num> rxSelectedQuickStartIndex;
  final Future<void> Function(num value) onQuickStartChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          outerCustomListView(context),
          const SizedBox(height: 8.0),
          innerCustomListView(
            context,
            rxQuickStart[rxSelectedQuickStartIndex.value.toInt()].innerList.obs,
          ),
        ],
      );
    });
  }

  Widget outerCustomListView(BuildContext context) {
    return CustomListView<QuickStartModelOuter>(
      // ignore: invalid_use_of_protected_member
      items: rxQuickStart.value,
      itemBuilder: outerItemBuilder,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget outerItemBuilder(
    BuildContext context,
    int index,
    QuickStartModelOuter item,
  ) {
    final bool is1st = index == 0;
    final bool isNth = index == rxQuickStart.length - 1;

    return Container(
      margin: EdgeInsets.only(
        left: is1st ? 8.0 : 4.0,
        right: isNth ? 8.0 : 4.0,
      ),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(() {
            return CustomChip.choice(
              label: item.title,
              selected: rxSelectedQuickStartIndex.value == index,
              onPressed: ([bool? v]) async {
                await onQuickStartChanged(num.parse(index.toString()));
              },
            );
          }),
        ],
      ),
    );
  }

  Widget innerCustomListView(
    BuildContext context,
    RxList<QuickStartModelInner> innerList,
  ) {
    return CustomListView<QuickStartModelInner>(
      key: ValueKey<num>(rxSelectedQuickStartIndex.value), // Do not remove this
      // ignore: invalid_use_of_protected_member
      items: innerList.value,
      itemBuilder: innerItemBuilder,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget innerItemBuilder(
    BuildContext context,
    int index,
    QuickStartModelInner item,
  ) {
    final bool is1st = index == 0;
    final bool isNth = index == rxQuickStart[index].innerList.length - 1;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: kToolbarHeight * 3,
        maxHeight: kToolbarHeight * 3,
        minWidth: kToolbarHeight * 6,
        maxWidth: kToolbarHeight * 6,
      ),
      child: CustomContainer(
        margin: EdgeInsets.only(
          left: is1st ? 8.0 : 4.0,
          right: isNth ? 8.0 : 4.0,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            // const FlutterLogo(size: kToolbarHeight * 2),
            // const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: CustomText(
                      data: item.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Flexible(
                    child: CustomText(
                      data: item.subtitle,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Flexible(
                    child: CustomText(
                      data: item.timestamp,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Flexible(
                    child: CustomElevatedButton(
                      onPressed: () async {},
                      data: item.buttonText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
