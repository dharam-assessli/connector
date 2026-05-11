import "package:connector/constants/colors_constants.dart";
import "package:connector/functions/chart_functions.dart";
import "package:connector/models/dashboard/chart/bucket_model.dart";
import "package:flutter/material.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:simple_ripple_animation/simple_ripple_animation.dart";
//

class ChartAnnotations extends StatelessWidget {
  const ChartAnnotations({required this.bucketList, super.key});
  final List<BucketModel> bucketList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        customContainer(context),
        const SizedBox(height: 8),
        annotation(context),
      ],
    );
  }

  Widget annotation(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RippleAnimation(
                repeat: true,
                ripplesCount: 0,
                color: ColorsConstants().blue,
                minRadius: 16,
                maxRadius: 16,
                delay: const Duration(seconds: 1),
                child: CircleAvatar(
                  foregroundColor: ColorsConstants().blue,
                  backgroundColor: ColorsConstants().transparent,
                  minRadius: 16,
                  maxRadius: 16,
                  child: const Icon(Icons.circle, size: 16),
                ),
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: CustomText(
                  data: "Predicted",
                  style: TextStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RippleAnimation(
                repeat: true,
                ripplesCount: 0,
                color: ColorsConstants().green,
                minRadius: 16,
                maxRadius: 16,
                delay: const Duration(seconds: 1),
                child: CircleAvatar(
                  foregroundColor: ColorsConstants().green,
                  backgroundColor: ColorsConstants().transparent,
                  minRadius: 16,
                  maxRadius: 16,
                  child: const Icon(Icons.circle, size: 16),
                ),
              ),
              const SizedBox(width: 4),
              const Flexible(
                child: CustomText(
                  data: "Achieved",
                  style: TextStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget customContainer(final BuildContext context) {
    return CustomContainer(
      onTap: () async {},
      borderRadius: BorderRadius.circular(360),
      padding: const EdgeInsets.all(8.0),
      child: CustomText(
        data: "Productivity score: ${getPercentage(bucketList)}",
        style: const TextStyle(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
