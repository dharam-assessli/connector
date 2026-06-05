import "package:connector/constants/strings_constants.dart";
import "package:connector/controllers/onboarding/your_details_controller.dart";
import "package:connector/controllers/settings/settings_controller.dart";
import "package:connector/utils/routes_utils.dart";
import "package:get/get.dart";
import "package:horizon/services/custom_tabs_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/bottom_sheet/account_sheet.dart" as account;
import "package:horizon/widgets/bottom_sheet/settings_sheet.dart" as settings;
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(needHelpButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                accountSection(context),
                const SizedBox(height: 16),
                syncSection(context),
                const SizedBox(height: 16),
                legalSection(context),
                const SizedBox(height: 16),
                shareAndRateSection(context),
                const SizedBox(height: 16),
                feedbackAndReportSection(context),
                const SizedBox(height: 16),
                deactivateAndDeleteSection(context),
                const SizedBox(height: 16),
                signOutSection(context),
                const SizedBox(height: 16),
                appVersionSection(context),
                const SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget accountSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          data: "Account Section",
          style: TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        commonCustomContainer(
          context: context,
          title: "Profile setting",
          onTap: () async {
            final String route = RoutesUtils().yourDetailsScreen;

            final Map<String, String> arguments = <String, String>{
              "navigationSource": NavigationSource.home.name,
            };

            await NavigationService().pushNamed(route, arguments: arguments);
          },
        ),
      ],
    );
  }

  Widget syncSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          data: "Sync Section",
          style: TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Automatic sync setting",
                onTap: () async {
                  final String route = RoutesUtils().connectorScreen;

                  final Map<String, String> arguments = <String, String>{};

                  await NavigationService().pushNamed(
                    route,
                    arguments: arguments,
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Manual sync setting",
                onTap: () async {
                  final String route = RoutesUtils().manualSyncScreen;

                  final Map<String, String> arguments = <String, String>{};

                  await NavigationService().pushNamed(
                    route,
                    arguments: arguments,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget legalSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          data: "Legal Section",
          style: TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Privacy Policy",
                onTap: () async {
                  final String url = StringsConstants().privacyPolicyURL;

                  await CustomTabsService().open(url: url);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Terms & Conditions",
                onTap: () async {
                  final String url = StringsConstants().tAndCURL;

                  await CustomTabsService().open(url: url);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Help & Support",
                onTap: () async {
                  final String url = StringsConstants().supportWebsite;

                  await CustomTabsService().open(url: url);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "General FAQs",
                onTap: () async {
                  final String url = StringsConstants().generalFAQsURL;

                  await CustomTabsService().open(url: url);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Data Usage Disclosure",
                onTap: () async {
                  final String url = StringsConstants().dataUsageDisclosureURL;

                  await CustomTabsService().open(url: url);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "About us",
                onTap: () async {
                  final String url = StringsConstants().aboutUs;

                  await CustomTabsService().open(url: url);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget shareAndRateSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          data: "Share & Rate Section",
          style: TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Share this app",
                onTap: controller.openShare,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Rate this app",
                onTap: controller.openStore,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget feedbackAndReportSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          data: "Feedback & report section",
          style: TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Send us feedback",
                onTap: () async {
                  final (bool, String) result = await settings
                      .showSheetForSettings(settings.SheetType.feedback);

                  result.$1
                      ? await controller.sendFeedback(
                          settings.SheetType.feedback,
                          result.$2,
                        )
                      : (() {})();
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Send us bug report",
                onTap: () async {
                  final (bool, String) result = await settings
                      .showSheetForSettings(settings.SheetType.bug);

                  result.$1
                      ? await controller.sendFeedback(
                          settings.SheetType.bug,
                          result.$2,
                        )
                      : (() {})();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget deactivateAndDeleteSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomText(
          data: "Deactivate and delete section",
          style: TextStyle(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Deactivate your account",
                onTap: () async {
                  final bool result = await account.showSheetAccount(
                    account.SheetType.deactivation,
                  );

                  result ? await controller.deactivateAccount() : (() {})();
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: commonCustomContainer(
                context: context,
                title: "Delete your account",
                onTap: () async {
                  final bool result = await account.showSheetAccount(
                    account.SheetType.deletion,
                  );

                  result ? await controller.deleteAccount() : (() {})();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget signOutSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        commonCustomContainer(
          context: context,
          title: "Sign out",
          onTap: controller.signOut,
        ),
      ],
    );
  }

  Widget appVersionSection(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(
          data: "Version: ${controller.appVersion.value}",
          style: TextStyle(color: Theme.of(context).hintColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget commonCustomContainer({
    required final BuildContext context,
    required String title,
    required Future<void> Function() onTap,
  }) {
    return CustomContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: CustomText(
                    data: title,
                    style: TextStyle(color: Theme.of(context).hintColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_outlined, size: 16),
        ],
      ),
    );
  }
}
