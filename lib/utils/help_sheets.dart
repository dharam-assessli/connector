import "dart:developer";

import "package:connector/models/introduction/introduction_model.dart";
import "package:connector/utils/languages_util.dart";
import "package:horizon/utils/overlays/custom_bottom_sheet.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

Future<void> introLocationSheet() async {
  return openIntroductionBottomSheet(introLocation);
}

Future<void> introHealthSheet() async {
  return openIntroductionBottomSheet(introHealth);
}

Future<void> introScreenSheet() async {
  return openIntroductionBottomSheet(introScreen);
}

Future<void> introNotificationSheet() async {
  return openIntroductionBottomSheet(introNotification);
}

Future<void> openIntroductionBottomSheet(final IntroductionModel item) async {
  try {
    await CustomBottomSheet().show(
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
      needConfirmButton: true,
      textConfirmButton: LanguagesUtil().understood,
    );
  } on Exception catch (error, stackTrace) {
    log("Exception", error: error, stackTrace: stackTrace);
  } finally {}

  return Future<void>.value();
}
