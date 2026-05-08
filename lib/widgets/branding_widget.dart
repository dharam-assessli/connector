import "package:connector/constants/images_constants.dart";
import "package:connector/utils/languages_util.dart";
import "package:horizon/utils/shine_animation.dart";
import "package:horizon/widgets/gradient/custom_gradient_text.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:material_ui/material_ui.dart";

class BrandingWidget extends StatefulWidget {
  const BrandingWidget({super.key});

  @override
  State<BrandingWidget> createState() => _BrandingWidgetState();
}

class _BrandingWidgetState extends State<BrandingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final Duration duration = const Duration(seconds: 60);

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: duration, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      await controller.repeat();
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

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
      child: RotationTransition(
        turns: controller,
        child: CustomMediaViewer(
          data: ImagesConstants().appIcon,
          height: kToolbarHeight * 3,
          width: kToolbarHeight * 3,
        ),
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
