import "package:flutter/material.dart";
import "package:horizon/widgets/builders/custom_list_view.dart";
import "package:horizon/widgets/containers/custom_container_2.dart";
import "package:horizon/widgets/texts/custom_text.dart";
//

class HomeCarouselSliderType3 extends StatelessWidget {
  const HomeCarouselSliderType3({required this.currentIndex, super.key});
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
                // must be current index 3
                isCurrent: value == 3,
                child: Container(
                  padding: const EdgeInsets.only(top: 24 * 2),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
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
                              CustomListView<String>(
                                items: List<String>.generate(10, (int index) {
                                  return "Item $index";
                                }),
                                itemBuilder:
                                    (BuildContext p0, int p1, String p2) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.circle,
                                            size: 16.0,
                                            color: Theme.of(context).hintColor,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Flexible(
                                            child: CustomText(
                                              data: p2,
                                              style: const TextStyle(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
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
