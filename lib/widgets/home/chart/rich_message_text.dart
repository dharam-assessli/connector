import "dart:developer";

import "package:connector/models/dashboard/chart/rich_segment_model.dart";
import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";
import "package:horizon/functions/empty_functions.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class RichMessageText extends StatelessWidget {
  const RichMessageText({
    required this.richMessage,
    this.onTap = emptyFutureFunction,
    super.key,
  });
  final RichMessage richMessage;
  final Future<void> Function() onTap;

  FontWeight parseWeight(String w) {
    switch (w) {
      case "bold":
        return FontWeight.bold;
      case "semibold":
        return FontWeight.w600;
      case "regular":
      default:
        return FontWeight.w400;
    }
  }

  Color resolveColor(String hex, Color themeColor) {
    Color value = themeColor;

    try {
      final Color parsed = HexColor(hex);

      value = (parsed.a == 0) ? themeColor : parsed;
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle base = Theme.of(context).textTheme.bodyMedium!;
    final List<TextSpan> spans = richMessage.segments.map<TextSpan>((
      RichSegmentModel e,
    ) {
      return TextSpan(
        text: e.text,
        style: base.copyWith(
          color: resolveColor(e.color, base.color!),
          fontWeight: parseWeight(e.weight),
        ),
      );
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 8),
            const Icon(Icons.auto_awesome_outlined, size: 24),
            const SizedBox(width: 8),
            Flexible(
              child: RichText(
                text: TextSpan(style: base, children: spans),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 8 * 5),
            Expanded(
              child: CustomContainer(
                onTap: onTap,
                borderRadius: BorderRadius.circular(360),
                padding: const EdgeInsets.all(8.0),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 8),
                    Flexible(
                      child: CustomText(
                        data: "View insights",
                        style: TextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.open_in_new, size: 16),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8 * 5),
          ],
        ),
      ],
    );
  }
}
