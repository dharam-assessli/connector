import "package:connector/controllers/dashboard/tabs/tab_profile_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:get/get.dart";
import "package:horizon/widgets/buttons/custom_text_button.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

class TabProfileScreen extends GetView<TabProfileController> {
  const TabProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[basicInfoWidget(context)],
    );
  }

  Widget basicInfoWidget(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: kToolbarHeight,
          width: kToolbarHeight,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CustomMediaViewer(data: controller.contructImageURL),
        ),
        const SizedBox(height: 16),
        CustomText(
          data: controller.rxUser.value.displayName ?? "",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        CustomText(
          data: controller.rxUser.value.email ?? "",
          style: const TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: CustomTextButton(
                data: LanguagesUtil().signOut,
                onPressed: controller.onSignOutTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
