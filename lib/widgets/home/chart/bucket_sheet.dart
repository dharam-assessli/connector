import "package:connector/functions/chart_functions.dart";
import "package:connector/models/dashboard/chart/bucket_model.dart";
import "package:connector/widgets/home/chart/gradient_slider_track_shape.dart";
import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";
import "package:horizon/utils/overlays/custom_bottom_sheet.dart";
import "package:horizon/widgets/builders/custom_list_view.dart";
import "package:horizon/widgets/texts/custom_text.dart";

Future<void> showBucketSheet({required List<BucketModel> bucketList}) async {
  await CustomBottomSheet().show(child: BucketSheet(bucketList: bucketList));

  return Future<void>.value();
}

class BucketSheet extends StatelessWidget {
  const BucketSheet({required this.bucketList, super.key});
  final List<BucketModel> bucketList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        productivityText(context),
        const SizedBox(height: 16),
        productivityBars(context),
        const SizedBox(height: 16),
        scoreText(context),
        const SizedBox(height: 16),
        customListView(context),
      ],
    );
  }

  Widget productivityText(final BuildContext context) {
    return CustomText(
      data: "Today's Productivity Score",
      style: TextStyle(
        fontSize: 24,
        color: Theme.of(context).textTheme.bodyMedium?.color,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget productivityBars(final BuildContext context) {
    const int totalBars = 50;

    if (bucketList.isEmpty) {
      return const SizedBox();
    }

    final double avgScore =
        bucketList.fold<num>(0, (num s, BucketModel b) {
          return s + b.score;
        }) /
        bucketList.length;

    final int activeBars = ((avgScore / 100) * totalBars).round();

    final double sumScores = bucketList.fold<num>(0, (num s, BucketModel b) {
      return s + b.score;
    }).toDouble();

    final List<double> exact = bucketList.map((BucketModel b) {
      return sumScores == 0 ? 0.0 : (b.score / sumScores) * activeBars;
    }).toList();

    final List<int> assigned = exact.map((double e) {
      return e.floor();
    }).toList();

    final int leftover =
        activeBars -
        assigned.fold<int>(0, (int s, int n) {
          return s + n;
        });

    if (leftover > 0) {
      final List<int> indices =
          List<int>.generate(bucketList.length, (int i) {
            return i;
          })..sort((int a, int b) {
            return (exact[b] - assigned[b]).compareTo(exact[a] - assigned[a]);
          });

      for (int i = 0; i < leftover && i < indices.length; i++) {
        assigned[indices[i]] += 1;
      }
    }

    final List<Color> barColors = <Color>[
      for (int i = 0; i < bucketList.length; i++)
        ...List<Color>.filled(assigned[i], HexColor(bucketList[i].hexColor)),
    ];

    barColors.addAll(
      List<Color>.filled(
        totalBars - barColors.length,
        Theme.of(context).hintColor.withAlpha(16),
      ),
    );

    return SizedBox(
      height: kToolbarHeight * 2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double barWidth = constraints.maxWidth / barColors.length;

          return CustomListView<Color>(
            items: barColors,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index, Color item) {
              return SizedBox(
                width: barWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[item, item.withAlpha(16)],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget scoreText(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: CustomText(
            data: "Productivity Score",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).hintColor,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: CustomText(
            data: getPercentage(bucketList),
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget customListView(final BuildContext context) {
    return CustomListView<BucketModel>(
      items: bucketList,
      itemBuilder: (BuildContext context, int index, BucketModel item) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: kToolbarHeight / 2),
            CustomText(
              data: item.title,
              style: const TextStyle(fontWeight: FontWeight.normal),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 4,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 16,
                  ),
                  trackHeight: 4,
                  trackShape: GradientSliderTrackShape(
                    gradient: LinearGradient(
                      colors: <Color>[
                        HexColor(item.hexColor).withAlpha(16),
                        HexColor(item.hexColor),
                      ],
                    ),
                    fallbackInactiveColor: Theme.of(
                      context,
                    ).hintColor.withAlpha(16),
                  ),
                ),
                child: Slider(
                  divisions: 100,
                  value: item.score / 100,
                  onChanged: (double value) {},
                  label: "${item.score}%",
                  padding: EdgeInsets.zero,
                  thumbColor: HexColor(item.hexColor),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomText(
              data: "${item.score}%",
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: kToolbarHeight / 2),
          ],
        );
      },
    );
  }
}
