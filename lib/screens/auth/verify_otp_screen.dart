// ignore_for_file: avoid_redundant_argument_values

import "package:connector/controllers/auth/verify_otp_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/widgets/branding_widget.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:horizon/services/sms_retriever_service.dart";
import "package:horizon/utils/otp/otp_timer_util.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:pinput/pinput.dart";

class VerifyOTPScreen extends GetView<VerifyOTPController> {
  const VerifyOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(
        child: SafeArea(
          child: Obx(() {
            return SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height:
                    Get.height -
                    MediaQuery.of(context).padding.vertical -
                    kBottomNavigationBarHeight,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Spacer(),
                    const BrandingWidget(),
                    const Spacer(),
                    botttomWidget(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget botttomWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 08),
          titleAndSubtitleWidget(context),
          const SizedBox(height: 16),
          otpInputWidget(context),
          const SizedBox(height: 16),
          otpTimerWidget(context),
          const SizedBox(height: 08),
        ],
      ),
    );
  }

  Widget titleAndSubtitleWidget(BuildContext context) {
    final bool isAPhoneNumber = controller.rxIsAPhoneNumber.value;

    final String dialCode = controller.rxSelectedCountry.value.dialCode ?? "";
    final String number = controller.rxNumber.value;
    final String email = controller.rxEmail.value;

    final String title = isAPhoneNumber
        ? LanguagesUtil().verifyYourPhoneNumber
        : LanguagesUtil().verifyYourEmail;
    final String subtitle = isAPhoneNumber
        ? "${LanguagesUtil().enterTheCodeSentToPhone} $dialCode $number."
        : "${LanguagesUtil().enterTheCodeSentToEmail} $email.";

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomText(
          data: title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        CustomText(
          data: subtitle,
          style: const TextStyle(fontWeight: FontWeight.normal),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget otpInputWidget(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color color = Theme.of(context).scaffoldBackgroundColor;

    return Pinput(
      smsRetriever: SmsRetrieverImpl(),
      controller: controller.otpTextController,
      onChanged: controller.rxOTP.call,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty
            ? LanguagesUtil().required
            : text.length != 4
            ? LanguagesUtil().otpValidationError
            : null;
      },
      autofillHints: const <String>[AutofillHints.oneTimeCode],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      length: 4,
      defaultPinTheme: PinTheme(
        height: kToolbarHeight,
        width: Get.width,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          color: isDark
              ? color.withValues(alpha: 0.64)
              : color.withValues(alpha: 0.32),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
      ),
      onCompleted: (String value) async {
        // Validate form
        final bool isValid = controller.validateForm();

        if (!isValid) {
          return Future<void>.value();
        } else {}

        // Verify OTP and navigate if success
        await controller.verifyOTP();
      },
    );
  }

  Widget otpTimerWidget(BuildContext context) {
    return OTPTimerUtil(onTimerEnd: controller.resendOTP);
  }
}
