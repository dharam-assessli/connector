import "package:connector/constants/images_constants.dart";
import "package:flutter/material.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";

class HomeHumanImageWidget extends StatelessWidget {
  const HomeHumanImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return customMediaViewer(context);
  }

  Widget customMediaViewer(final BuildContext context) {
    return CustomMediaViewer(
      data: ImagesConstants().homeHuman,
      height: kToolbarHeight * 6.0,
      width: double.infinity,
    );
  }
}
