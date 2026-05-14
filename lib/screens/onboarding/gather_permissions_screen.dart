import "package:connector/controllers/onboarding/gather_permissions_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:get/get.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/builders/custom_page_view.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

class GatherPermissionsScreen extends GetView<GatherPermissionsController> {
  const GatherPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 0.0),
              Expanded(child: customPageView(context)),
              const SizedBox(height: 0.0),
              buttonWidget(),
              const SizedBox(height: 0.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget customPageView(final BuildContext context) {
    return CustomPageView<PermissionType>(
      pageController: controller.pageController,
      items: controller.getPermissionTypes,
      itemBuilder: itemBuilder,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (final int index) {
        controller.rxCurrentPage.value = index;
      },
    );
  }

  Widget itemBuilder(
    final BuildContext context,
    final int index,
    final PermissionType type,
  ) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Icon(controller.getIconData(index), size: kToolbarHeight),
            ),
            const SizedBox(height: 16.0),
            CustomText(
              data: controller.getHeading(index),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),
            CustomText(
              data: controller.getTopDescription(index),
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),
            CustomText(
              data: controller.getBtmDescription(index),
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: CustomContainer(
            onTap: controller.onTap,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            borderRadius: BorderRadius.circular(360),
            child: CustomText(
              data: LanguagesUtil().continueText,
              style: const TextStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
