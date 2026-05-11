import "package:connector/functions/mood_functions.dart";
import "package:connector/models/dashboard/mood/mood_model.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/widgets/others/infinite_rotate_widget.dart";
import "package:horizon/widgets/sliders/custom_slider.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_shapes/material_shapes.dart";

class MoodWidget extends StatelessWidget {
  const MoodWidget({
    required this.rxMood,
    required this.rxSelectedMoodIndex,
    required this.onMoodChanged,
    super.key,
  });
  final Rx<Mood> rxMood;
  final Rx<num> rxSelectedMoodIndex;
  final Future<void> Function(num value) onMoodChanged;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          mainWidget(context),
          const SizedBox(height: 8.0),
          sliderWidget(context),
        ],
      );
    });
  }

  Widget mainWidget(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight * 4,
      width: kToolbarHeight * 4,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          for (final MoodModel ring in <MoodModel>[
            const MoodModel(size: kToolbarHeight * 4.0, progress: 0.08),
            const MoodModel(size: kToolbarHeight * 3.4, progress: 0.20),
            const MoodModel(size: kToolbarHeight * 2.8, progress: 0.40),
            const MoodModel(size: kToolbarHeight * 2.2, progress: 0.60),
            const MoodModel(size: kToolbarHeight * 1.6, progress: 0.80),
            const MoodModel(size: kToolbarHeight * 1.0, progress: 1.00),
          ])
            InfiniteRotateWidget(
              widget: buildShape(
                mood: Mood.values[rxSelectedMoodIndex.value.toInt()],
                size: ring.size,
                color: Color.lerp(
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.primary,
                  ring.progress,
                )!,
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(
                data: "Mood",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText(
                data: buildLabel(rxMood.value),
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sliderWidget(BuildContext context) {
    return CustomSlider(
      max: Mood.values.length - 1,
      divisions: Mood.values.length - 1,
      value: rxSelectedMoodIndex.value.toDouble(),
      onChanged: (double p0) async {
        await onMoodChanged(num.parse(p0.toInt().toString()));
      },
    );
  }

  Widget buildShape({
    required Mood mood,
    required double size,
    required Color color,
  }) {
    switch (mood) {
      case Mood.heart:
        return MaterialShapes.heart(size: size, color: color);
      // case Mood.bun:
      //   return MaterialShapes.bun(size: size, color: color);
      // case Mood.pixelTriangle:
      //   return MaterialShapes.pixelTriangle(size: size, color: color);
      // case Mood.pixelCircle:
      //   return MaterialShapes.pixelCircle(size: size, color: color);
      // case Mood.ghostish:
      //   return MaterialShapes.ghostish(size: size, color: color);
      case Mood.puffyDiamond:
        return MaterialShapes.puffyDiamond(size: size, color: color);
      case Mood.puffy:
        return MaterialShapes.puffy(size: size, color: color);
      case Mood.flower:
        return MaterialShapes.flower(size: size, color: color);
      case Mood.softBloom:
        return MaterialShapes.softBloom(size: size, color: color);
      // case Mood.bloom:
      //   return MaterialShapes.bloom(size: size, color: color);
      case Mood.softBurst:
        return MaterialShapes.softBurst(size: size, color: color);
      // case Mood.burst:
      //   return MaterialShapes.burst(size: size, color: color);
      case Mood.eightLeafClover:
        return MaterialShapes.eightLeafClover(size: size, color: color);
      case Mood.fourLeafClover:
        return MaterialShapes.fourLeafClover(size: size, color: color);
      case Mood.twelveSidedCookie:
        return MaterialShapes.twelveSidedCookie(size: size, color: color);
      // case Mood.nineSidedCookie:
      //   return MaterialShapes.nineSidedCookie(size: size, color: color);
      // case Mood.sevenSidedCookie:
      //   return MaterialShapes.sevenSidedCookie(size: size, color: color);
      case Mood.sixSidedCookie:
        return MaterialShapes.sixSidedCookie(size: size, color: color);
      // case Mood.fourSidedCookie:
      //   return MaterialShapes.fourSidedCookie(size: size, color: color);
      case Mood.sunny:
        return MaterialShapes.sunny(size: size, color: color);
      // case Mood.verySunny:
      //   return MaterialShapes.verySunny(size: size, color: color);
      case Mood.gem:
        return MaterialShapes.gem(size: size, color: color);
      case Mood.pentagon:
        return MaterialShapes.pentagon(size: size, color: color);
      case Mood.clampShell:
        return MaterialShapes.clampShell(size: size, color: color);
      // case Mood.diamond:
      //   return MaterialShapes.diamond(size: size, color: color);
      // case Mood.fan:
      //   return MaterialShapes.fan(size: size, color: color);
      // case Mood.arrow:
      //   return MaterialShapes.arrow(size: size, color: color);
      // case Mood.triangle:
      //   return MaterialShapes.triangle(size: size, color: color);
      // case Mood.pill:
      //   return MaterialShapes.pill(size: size, color: color);
      // case Mood.oval:
      //   return MaterialShapes.oval(size: size, color: color);
      // case Mood.semicircle:
      //   return MaterialShapes.semicircle(size: size, color: color);
      // case Mood.arch:
      //   return MaterialShapes.arch(size: size, color: color);
      // case Mood.slanted:
      //   return MaterialShapes.slanted(size: size, color: color);
      // case Mood.square:
      //   return MaterialShapes.square(size: size, color: color);
      case Mood.circle:
        return MaterialShapes.circle(size: size, color: color);
    }
  }
}
