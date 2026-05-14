import "dart:io";

import "package:connector/models/auth/send_otp.dart";
import "package:connector/repositories/auth/auth_repository.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/models/countries/countries.dart";
import "package:horizon/services/country_find_service.dart";
import "package:horizon/services/identify_service.dart";
import "package:horizon/services/jwt/auth_refresh_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/services/sms_service.dart";
import "package:horizon/utils/bottom_sheets/countries_sheet.dart";
import "package:horizon/utils/overlays/snack_bar_util.dart";

class SignInController extends GetxController {
  final Rx<Countries> rxSelectedCountry = Countries(
    name: "United States",
    code: "US",
    dialCode: "+1",
    flag: "🇺🇸",
    minLength: 10,
    maxLength: 10,
  ).obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController numberTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();

  final RxString rxNumber = "".obs;
  final RxString rxEmail = "".obs;

  final RxBool rxIsAPhoneNumber = true.obs;
  final RxBool rxIsAcceptedTerm = true.obs;

  @override
  void onInit() {
    super.onInit();

    setCountryCode();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    if (Platform.isAndroid) {
      await openHint();
    }
  }

  Future<void> toggleMethod() async {
    rxIsAPhoneNumber.value = !rxIsAPhoneNumber.value;

    return Future<void>.value();
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleTermsAccepted(bool? value) async {
    rxIsAcceptedTerm.value = value ?? rxIsAcceptedTerm.value;

    return Future<void>.value();
  }

  void setCountryCode([Countries? selected]) {
    final Countries result = selected ?? CountryFindService().find();

    rxSelectedCountry.value = result;

    return;
  }

  Future<void> openHint() async {
    final String hintResult = await SMSService().requestPhoneNumberHint();

    await read(hintResult);

    return Future<void>.value();
  }

  Future<void> read(String hintResult) async {
    if (hintResult.isEmpty) {
      return Future<void>.value();
    } else {}

    // Extract country code and number from the hint result
    final (Countries?, String) identifyResult = IdentifyService().extract(
      hintResult,
    );

    setCountryCode(identifyResult.$1);

    numberTextController.text = identifyResult.$2;
    rxNumber.value = identifyResult.$2;

    return Future<void>.value();
  }

  Future<void> onTapDialCode() async {
    final Countries selected = rxSelectedCountry.value;

    final Countries? result = await CountriesSheet().show(selected: selected);

    setCountryCode(result);

    return Future<void>.value();
  }

  int get minLength {
    return rxSelectedCountry.value.minLength ?? 0;
  }

  int get maxLength {
    return rxSelectedCountry.value.maxLength ?? 0;
  }

  bool validateForm() {
    const bool value = false;

    final bool result1 = formKey.currentState?.validate() ?? false;
    if (!result1) {
      SnackBarUtil().show(LanguagesUtil().pleaseFillAllFields);
      return value;
    }

    final bool result2 = rxIsAcceptedTerm.value;
    if (!result2) {
      SnackBarUtil().show(LanguagesUtil().pleaseAcceptTerms);
      return value;
    }

    return result1 && result2;
  }

  Future<bool> sendOTP() async {
    final String dialCode = rxSelectedCountry.value.dialCode ?? "";
    final String number = rxNumber.value;
    final String email = rxEmail.value;
    final String signature = await SMSService().getAppSignature();

    final SendOTP result = await AuthRepository().sendOTP(<String, dynamic>{
      "method": rxIsAPhoneNumber.value ? "phone" : "email",
      "destination": rxIsAPhoneNumber.value ? "$dialCode$number" : email,
      "app_signature": signature,
    });

    final bool value = !mapEquals(result.toJson(), SendOTP().toJson());

    return Future<bool>.value(value);
  }

  Future<void> navigate() async {
    await NavigationService().pushNamed(
      RoutesUtils().verifyOTPScreen,
      arguments: <String, dynamic>{
        "selectedCountry": rxSelectedCountry.value.toJson(),
        "number": rxNumber.value,
        "email": rxEmail.value,
        "isAPhoneNumber": rxIsAPhoneNumber.value,
      },
    );

    return Future<void>.value();
  }

  Future<void> signInWithGoogle() async {
    final bool result = rxIsAcceptedTerm.value;
    if (!result) {
      SnackBarUtil().show(LanguagesUtil().pleaseAcceptTerms);
      return Future<void>.value();
    }

    await AuthRefreshService().google(
      navigate: () async {
        await NavigationService().pushNamedAndRemoveUntil(
          RoutesUtils().gatherPermissionsScreen,
          arguments: <String, dynamic>{},
          circularTransition: true,
        );
      },
    );

    return Future<void>.value();
  }

  Future<void> signInWithApple() async {
    final bool result = rxIsAcceptedTerm.value;
    if (!result) {
      SnackBarUtil().show(LanguagesUtil().pleaseAcceptTerms);
      return Future<void>.value();
    }

    await AuthRefreshService().apple(
      navigate: () async {
        await NavigationService().pushNamedAndRemoveUntil(
          RoutesUtils().gatherPermissionsScreen,
          arguments: <String, dynamic>{},
          circularTransition: true,
        );
      },
    );

    return Future<void>.value();
  }
}
