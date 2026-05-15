import "package:flutter/material.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:wave/config.dart";
import "package:wave/wave.dart";
import "package:waveform_flutter/waveform_flutter.dart";

class AINoteWidget extends StatelessWidget {
  const AINoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: CustomContainer(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: kToolbarHeight),

                bottomWaveWidget(context),

                const SizedBox(height: 0),
              ],
            ),
          ),
        ),
        Positioned(top: 8, left: 16, child: customTextAINoteWidget(context)),
        Positioned(
          top: 8,
          right: 16,
          child: CustomContainer(
            borderRadius: BorderRadius.circular(360),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.open_in_new, size: 16),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: CustomContainer(
                borderRadius: BorderRadius.circular(360),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.play_arrow, size: 32),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 16,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(360),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: CustomContainer(
              borderRadius: BorderRadius.circular(360),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: CustomText(
                  data: "00:00",
                  style: TextStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customTextAINoteWidget(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(width: 0),
          CustomContainer(
            borderRadius: BorderRadius.circular(360),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.record_voice_over_outlined, size: 16),
            ),
          ),
          const SizedBox(width: 8),
          const Flexible(
            child: CustomText(
              data: "AI Note",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 0),
        ],
      ),
    );
  }

  Widget middleWaveWidget(final BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: AnimatedWaveList(
        stream: createRandomAmplitudeStream(),
        barBuilder: (Animation<double> animation, Amplitude amplitude) {
          final double barHeight = 4 + (amplitude.current / 100) * 56.0;

          return SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                height: barHeight,
                width: 2.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primaryContainer,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomWaveWidget(final BuildContext context) {
    return WaveWidget(
      waveAmplitude: 16.0,
      size: const Size(double.infinity, kToolbarHeight),
      config: CustomConfig(
        gradients: <List<Color>>[
          <Color>[
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
          <Color>[
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ],
        durations: <int>[10000, 100000],
        heightPercentages: <double>[0.24, 0.56],
        blur: const MaskFilter.blur(BlurStyle.normal, 8),
      ),
    );
  }
}
