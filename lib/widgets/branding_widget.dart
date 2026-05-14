import "package:connector/constants/images_constants.dart";
import "package:connector/utils/languages_util.dart";
import "package:flutter/material.dart";
import "package:horizon/utils/shine_animation.dart";
import "package:horizon/widgets/gradient/custom_gradient_text.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";

// This widget is used to display the branding of the app.
class BrandingWidget extends StatelessWidget {
  const BrandingWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return brandingWidget(context);
  }

  Widget brandingWidget(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 00),
        customMediaViewer(context),
        const SizedBox(height: 16),
        customGradientText(context),
        const SizedBox(height: 00),
      ],
    );
  }

  Widget customMediaViewer(final BuildContext context) {
    return ShineAnimation(
      color: ShineColor.primaryContainer,
      child: CustomMediaViewer(
        data: ImagesConstants().appIcon,
        height: kToolbarHeight * 3,
        width: kToolbarHeight * 3,
      ),
    );
  }

  Widget customGradientText(final BuildContext context) {
    return CustomGradientText(
      data: LanguagesUtil().appName,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    );
  }
}
