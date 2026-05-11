import "package:carousel_slider/carousel_slider.dart";
import "package:connector/widgets/home/carousel_slider/home_carousel_slider_type_0.dart";
import "package:connector/widgets/home/carousel_slider/home_carousel_slider_type_1.dart";
import "package:connector/widgets/home/carousel_slider/home_carousel_slider_type_2.dart";
import "package:connector/widgets/home/carousel_slider/home_carousel_slider_type_3.dart";
import "package:flutter/material.dart";
import "package:horizon/widgets/carousel_slider/custom_carousel_slider.dart";

final ValueNotifier<int> globalCurrentIndex = ValueNotifier<int>(0);

class HomeCarouselSlider extends StatelessWidget {
  const HomeCarouselSlider({this.sliderController, super.key});
  final CarouselSliderController? sliderController;

  @override
  Widget build(BuildContext context) {
    return customCarouselSlider(context);
  }

  Widget customCarouselSlider(BuildContext context) {
    final ValueNotifier<int> localCurrentIndex = ValueNotifier<int>(
      globalCurrentIndex.value,
    );

    return Transform.flip(
      flipY: true,
      child: CustomCarouselSlider(
        controller: sliderController ?? CarouselSliderController(),
        options: CarouselOptions(
          height: kToolbarHeight * 6.56,
          enlargeCenterPage: true,
          viewportFraction: 0.56,
          enlargeFactor: 0.56,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          onPageChanged: (int index, CarouselPageChangedReason reason) {
            globalCurrentIndex.value = index;
            localCurrentIndex.value = index;
          },
        ),
        items: <Widget>[
          HomeCarouselSliderType0(currentIndex: localCurrentIndex),
          HomeCarouselSliderType1(currentIndex: localCurrentIndex),
          HomeCarouselSliderType2(currentIndex: localCurrentIndex),
          HomeCarouselSliderType3(currentIndex: localCurrentIndex),
        ],
      ),
    );
  }
}
