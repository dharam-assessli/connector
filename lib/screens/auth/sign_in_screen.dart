import "dart:io";

import "package:connector/constants/images_constants.dart";
import "package:connector/constants/strings_constants.dart";
import "package:connector/controllers/auth/sign_in_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/widgets/branding_widget.dart";
import "package:flutter/gestures.dart";
import "package:get/get.dart";
import "package:horizon/services/custom_tabs_service.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:horizon/widgets/texts/custom_text_rich.dart";
import "package:material_ui/material_ui.dart";

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 16),
              Expanded(child: brandingWidget(context)),
              const SizedBox(height: 16),
              socialButtonsWidget(context),
              const SizedBox(height: 16),
              customTextRich(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget brandingWidget(final BuildContext context) {
    return const BrandingWidget();
  }

  Widget socialButtonsWidget(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        signInWithGoogle(context),
        if (Platform.isIOS) const SizedBox(height: 16),
        if (Platform.isIOS) signInWithApple(context),
      ],
    );
  }

  Widget signInWithGoogle(final BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: Get.width / 2,
      child: CustomContainer(
        onTap: controller.handlerGoogle,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomMediaViewer(
              data: ImagesConstants().signInWithGoogle,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: CustomText(
                data: LanguagesUtil().signInWithGoogle,
                style: const TextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signInWithApple(final BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: Get.width / 2,
      child: CustomContainer(
        onTap: controller.handlerApple,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomMediaViewer(
              data: ImagesConstants().signInWithApple,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: CustomText(
                data: LanguagesUtil().signInWithApple,
                style: const TextStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextRich(final BuildContext context) {
    return CustomTextRich(
      textAlign: TextAlign.center,
      textSpan: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: "${LanguagesUtil().byContinuingYouAgreeToOur}\n",
            style: const TextStyle(),
          ),
          TextSpan(
            text: LanguagesUtil().termsOfService,
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final String url = StringsConstants().tAndCURL;
                
                await CustomTabsService().open(url: url);
              },
          ),
          TextSpan(text: " ${LanguagesUtil().and} ", style: const TextStyle()),
          TextSpan(
            text: LanguagesUtil().privacyPolicy,
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final String url = StringsConstants().privacyPolicyURL;

                await CustomTabsService().open(url: url);
              },
          ),
        ],
      ),
    );
  }
}
