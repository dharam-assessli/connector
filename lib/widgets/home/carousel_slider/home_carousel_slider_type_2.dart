import "package:connector/widgets/home/carousel_slider/curve_painter.dart";
import "package:flutter/material.dart";
import "package:horizon/widgets/containers/custom_container_2.dart";
import "package:horizon/widgets/gradient/custom_gradient_text.dart";
import "package:horizon/widgets/texts/custom_text.dart";
//
//

class HomeCarouselSliderType2 extends StatelessWidget {
  const HomeCarouselSliderType2({required this.currentIndex, super.key});
  final ValueNotifier<int> currentIndex;

  @override
  Widget build(final BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (BuildContext context, int value, Widget? child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Transform.flip(
            flipY: true,
            child: SizedBox(
              height: kToolbarHeight * 4,
              width: double.infinity,
              child: container(
                // must be current index 2
                isCurrent: value == 2,
                child: Container(
                  padding: const EdgeInsets.only(top: 24 * 2),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: kToolbarHeight / 2,
                        right: kToolbarHeight / 2,
                        top: kToolbarHeight - 16,
                        child: SizedBox(
                          height: kToolbarHeight * 3,
                          width: kToolbarHeight * 3,
                          child: CustomPaint(
                            painter: CurvePainter(),
                            child: Container(),
                          ),
                        ),
                      ),

                      const Positioned(
                        left: kToolbarHeight / 2,
                        right: kToolbarHeight / 2,
                        top: kToolbarHeight + 8 + 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.directions_run, size: 16.0),
                                SizedBox(width: 4.0),
                                Flexible(
                                  child: CustomText(
                                    data: "Steps",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            CustomGradientText(
                              animation: false,
                              data: "10,000",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        left: 8,
                        right: 8,
                        top: (kToolbarHeight * 2) + 8 + 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: CustomText(
                                data: "HSR Layoyt",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).hintColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: CustomText(
                                data: "Koramangala",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).hintColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 4,
                        child: CustomText(
                          data: "Achievement",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Positioned(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(height: 8.0),
                              CustomText(
                                data: "This month's goal",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).hintColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget container({required bool isCurrent, required Widget child}) {
    return isCurrent
        ? CustomContainer2(
            dipDepth: 24 * 2,
            dipSpace: 24 * 6,
            dipRadius: 24,
            child: child,
          )
        : CustomContainer2(child: child);
  }
}
