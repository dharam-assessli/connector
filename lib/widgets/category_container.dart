import "package:connector/utils/languages_util.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:horizon/widgets/buttons/custom_text_button.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    required this.icon,
    required this.heading,
    required this.onItemTap,
    required this.onHelpTap,
    required this.onSettingsTap,
    super.key,
  });

  final Widget icon;
  final String heading;
  final Future<void> Function() onItemTap;
  final Future<void> Function() onHelpTap;
  final Future<void> Function() onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return customContainer(context);
  }

  Widget customContainer(final BuildContext context) {
    return CustomContainer(
      onTap: onItemTap,
      child: Stack(
        children: <Widget>[
          Positioned(left: -16, child: topLWidget()),
          Positioned(right: 00, child: topRWidget()),
          Positioned(child: bodyWidget()),
        ],
      ),
    );
  }

  Widget topLWidget() {
    return Transform.rotate(
      angle: -32.0,
      child: Opacity(opacity: 0.5, child: icon),
    );
  }

  Widget topRWidget() {
    return Transform.rotate(
      angle: 0.0,
      child: Opacity(
        opacity: 0.5,
        child: CustomContainer(
          onTap: onHelpTap,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(4),
          borderRadius: BorderRadius.circular(360),
          child: const FaIcon(FontAwesomeIcons.question, size: 16.0),
        ),
      ),
    );
  }

  Widget bodyWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 32),
        CustomText(
          data: heading,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        CustomText(
          data: LanguagesUtil().tapToResync,
          style: const TextStyle(fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 32),
        const Divider(height: 0),
        CustomTextButton(
          data: LanguagesUtil().openSettings,
          onPressed: onSettingsTap,
        ),
        const Divider(height: 0),
      ],
    );
  }
}
