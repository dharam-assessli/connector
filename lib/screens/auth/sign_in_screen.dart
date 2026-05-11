import "package:connector/constants/images_constants.dart";
import "package:connector/constants/strings_constants.dart";
import "package:connector/controllers/auth/sign_in_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/widgets/branding_widget.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:horizon/services/custom_tabs_service.dart";
import "package:horizon/utils/min_max_length_input_formatter.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/buttons/custom_floating_button.dart";
import "package:horizon/widgets/buttons/custom_outlined_button.dart";
import "package:horizon/widgets/buttons/custom_text_button.dart";
import "package:horizon/widgets/dividers/custom_divider.dart";
import "package:horizon/widgets/fields/custom_text_form_field.dart";
import "package:horizon/widgets/media/custom_media_viewer.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:horizon/widgets/texts/custom_text_rich.dart";

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(
        child: SafeArea(
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Spacer(),
                const BrandingWidget(),
                const Spacer(),
                botttomWidget(context),
                const SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget botttomWidget(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 08),
            decisionWidget(context),
            const SizedBox(height: 08),
            checkboxWidget(context),
            const SizedBox(height: 08),
            switchMethodWidget(context),
            const SizedBox(height: 08),
            orContinueWithWidget(context),
            const SizedBox(height: 08),
            socialButtonsWidget(context),
            const SizedBox(height: 08),
          ],
        ),
      ),
    );
  }

  Widget decisionWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: controller.rxIsAPhoneNumber.value
              ? phoneNumberFieldWidget(context)
              : emailFieldWidget(context),
        ),
        const SizedBox(width: 16),
        fabWidget(context),
      ],
    );
  }

  Widget emailFieldWidget(BuildContext context) {
    return CustomTextFormField(
      controller: controller.emailTextController,
      onChanged: controller.rxEmail.call,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty
            ? LanguagesUtil().required
            : !text.isEmail
            ? LanguagesUtil().emailValidationError
            : null;
      },
      autofillHints: const <String>[AutofillHints.email],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().email,
      hintText: LanguagesUtil().emailHint,
    );
  }

  Widget phoneNumberFieldWidget(BuildContext context) {
    final String flag = controller.rxSelectedCountry.value.flag ?? "";
    final String dialCode = controller.rxSelectedCountry.value.dialCode ?? "";

    return CustomTextFormField(
      controller: controller.numberTextController,
      onChanged: (String value) async {
        // If - means user paste action. // Else - means user input action.
        if (value.isNotEmpty && controller.rxNumber.value.isEmpty) {
          await controller.read(value);
        } else {}

        controller.rxNumber.value = value;
      },
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty
            ? LanguagesUtil().required
            : text.length < controller.minLength
            ? LanguagesUtil().phoneNumberValidationError
            : null;
      },
      autofillHints: const <String>[AutofillHints.telephoneNumber],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
        // Only check if user manually typed something.
        if (controller.rxNumber.value.isNotEmpty)
          MinMaxLengthInputFormatter(
            min: controller.minLength,
            max: controller.maxLength,
          ),
      ],
      labelText: LanguagesUtil().phoneNumber,
      hintText: LanguagesUtil().phoneNumberHint,
      prefixIcon: CustomTextButton(
        data: "$flag $dialCode",
        onPressed: controller.onTapDialCode,
      ),
    );
  }

  Widget switchMethodWidget(BuildContext context) {
    return CustomTextButton(
      data: controller.rxIsAPhoneNumber.value
          ? LanguagesUtil().useEmail
          : LanguagesUtil().usePhone,
      onPressed: controller.toggleMethod,
    );
  }

  Widget fabWidget(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight - 8,
      width: kToolbarHeight - 8,
      child: CustomFloatingButton(
        data: const Icon(Icons.arrow_forward),
        onPressed: () async {
          final bool isValid = controller.validateForm();

          if (!isValid) {
            return Future<void>.value();
          } else {}

          final bool sent = await controller.sendOTP();

          if (!sent) {
            return Future<void>.value();
          } else {}

          // Navigate
          await controller.navigate();
        },
      ),
    );
  }

  Widget orContinueWithWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CustomDivider(isLeft: true),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomText(
            data: LanguagesUtil().orContinueWith,
            style: const TextStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const CustomDivider(isLeft: false),
      ],
    );
  }

  Widget socialButtonsWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: CustomOutlinedButton(
              onPressed: () async {},
              data: "",
              fullWidth: true,
              customChild: CustomMediaViewer(
                data: ImagesConstants().signInWithGoogle,
                height: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: CustomOutlinedButton(
              onPressed: () async {},
              data: "",
              fullWidth: true,
              customChild: CustomMediaViewer(
                data: ImagesConstants().signInWithApple,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).dividerColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget checkboxWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: controller.rxIsAcceptedTerm.value,
            onChanged: controller.toggleTermsAccepted,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomTextRich(
            textSpan: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "${LanguagesUtil().byCheckingBox} ",
                  style: const TextStyle(fontSize: 12),
                ),
                TextSpan(
                  text: LanguagesUtil().termsAndConditions,
                  style: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final String url = StringsConstants().tAndCURL;
                      await CustomTabsService().open(url: url);
                    },
                ),
                TextSpan(
                  text: " ${LanguagesUtil().and} ",
                  style: const TextStyle(fontSize: 12),
                ),
                TextSpan(
                  text: LanguagesUtil().privacyPolicy,
                  style: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final String url = StringsConstants().privacyPolicyURL;
                      await CustomTabsService().open(url: url);
                    },
                ),
                const TextSpan(text: ".", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
