import "package:connector/controllers/splash/splash_controller.dart";
import "package:connector/widgets/branding_widget.dart";
import "package:get/get.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:material_ui/material_ui.dart";

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget brandingWidget(final BuildContext context) {
    return const BrandingWidget();
  }
}
