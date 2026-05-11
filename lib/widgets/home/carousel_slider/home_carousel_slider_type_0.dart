import "package:flutter/material.dart";
import "package:horizon/utils/shine_animation.dart";
import "package:horizon/widgets/containers/custom_container_2.dart";
import "package:horizon/widgets/gradient/custom_gradient_text.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class HomeCarouselSliderType0 extends StatelessWidget {
  const HomeCarouselSliderType0({required this.currentIndex, super.key});
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
                // must be current index 0
                isCurrent: value == 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 24 * 2),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 8,
                        bottom: 8,
                        right: 8,
                        child: Opacity(
                          opacity: 0.16,
                          child: ShineAnimation(
                            color: ShineColor.primary,
                            child: CustomMediaViewer(
                              data: "https://i.postimg.cc/fTLLBcyF/moon.png",
                              height: kToolbarHeight - 8,
                              width: kToolbarHeight - 8,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
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
                              Opacity(
                                opacity: 1.0,
                                child: ShineAnimation(
                                  color: ShineColor.primary,
                                  child: CustomMediaViewer(
                                    data:
                                        "https://i.postimg.cc/fTLLBcyF/moon.png",
                                    height: kToolbarHeight - 8,
                                    width: kToolbarHeight - 8,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              CustomText(
                                data: "Lorem ipsum Lorem ipsum",
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
                                data: "Lorem ipsum Lorem ipsum",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8.0),
                              CustomText(
                                data: "Lorem ipsum Lorem ipsum",
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
