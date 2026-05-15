import "package:flutter/material.dart";
import "package:horizon/widgets/containers/custom_container_2.dart";
import "package:horizon/widgets/gradient/custom_gradient_text.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";
//

class HomeCarouselSliderType1 extends StatelessWidget {
  const HomeCarouselSliderType1({required this.currentIndex, super.key});
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
                // must be current index 1
                isCurrent: value == 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 24 * 2),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: kToolbarHeight / 2,
                        right: kToolbarHeight / 2,
                        bottom: -((kToolbarHeight * 3) / 2),
                        child: SizedBox(
                          height: kToolbarHeight * 3,
                          width: kToolbarHeight * 3,
                          child: CircularProgressIndicator(
                            value: 1.0,
                            strokeWidth: 1.0,
                            constraints: const BoxConstraints(),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),

                      Positioned(
                        left: kToolbarHeight / 2,
                        right: kToolbarHeight / 2,
                        bottom: kToolbarHeight / 6,
                        child: CustomMediaViewer(
                          data: "https://i.postimg.cc/W1VLGj55/salad.png",
                          height: kToolbarHeight - 0,
                          width: kToolbarHeight - 0,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
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
                                data: "Now",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).hintColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8.0),
                              const CustomGradientText(
                                animation: false,
                                data: "Light Food",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
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
