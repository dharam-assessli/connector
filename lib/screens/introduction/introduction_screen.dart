import "package:connector/controllers/introduction/introduction_controller.dart";
import "package:connector/models/introduction/introduction_model.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/builders/custom_page_view.dart";
import "package:horizon/widgets/buttons/custom_floating_button.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

class IntroductionScreen extends GetView<IntroductionController> {
  const IntroductionScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
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
                const Spacer(),
                Expanded(child: customPageView(context)),
                const Spacer(),
              ],
            ),
          ),
        ),
        floatingActionButton: CustomFloatingButton(
          onPressed: () async {
            if (controller.rxCurrentPage.value <
                controller.rxSlides.length - 1) {
              final int currentPage = controller.rxCurrentPage.value;

              await controller.animateToPage(index: currentPage + 1);
              await controller.updateCurrentPage(index: currentPage + 1);
            } else {
              await controller.navigate();
            }
          },
          data: FaIcon(
            controller.rxCurrentPage.value < controller.rxSlides.length - 1
                ? FontAwesomeIcons.arrowRight
                : FontAwesomeIcons.check,
            size: 24.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget customPageView(final BuildContext context) {
    return CustomPageView<IntroductionModel>(
      pageController: controller.pageController,
      // ignore: invalid_use_of_protected_member
      items: controller.rxSlides.value,
      itemBuilder: itemBuilder,
      onPageChanged: (final int index) async {
        await controller.updateCurrentPage(index: index);
      },
    );
  }

  Widget itemBuilder(
    final BuildContext context,
    final int index,
    final IntroductionModel item,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(child: item.icon),
          const SizedBox(height: 32),
          CustomText(
            data: item.heading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          CustomText(
            data: item.topDescription,
            style: const TextStyle(fontSize: 14),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          CustomText(
            data: item.bottomDescription,
            style: const TextStyle(fontSize: 12),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
