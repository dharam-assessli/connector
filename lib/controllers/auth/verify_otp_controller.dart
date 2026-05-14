import "dart:developer";

import "package:connector/utils/languages_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:horizon/models/auth/send_otp.dart";
import "package:horizon/models/countries/countries.dart";
import "package:horizon/repositories/auth/auth_repository.dart";
import "package:horizon/services/jwt/sign_in_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/services/sms_service.dart";
import "package:horizon/utils/overlays/snack_bar_util.dart";

class VerifyOTPController extends GetxController {
  final Rx<Countries> rxSelectedCountry = Countries(
    name: "United States",
    code: "US",
    dialCode: "+1",
    flag: "🇺🇸",
    minLength: 10,
    maxLength: 10,
  ).obs;

  final TextEditingController numberTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  final RxString rxNumber = "".obs;
  final RxString rxEmail = "".obs;
  final RxString rxOTP = "".obs;

  final RxBool rxIsAPhoneNumber = true.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;

      // Set data from arguments
      setData(args);
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await getAppSignature();
  }

  // Set data from arguments
  void setData(Map<String, dynamic> args) {
    if (args.containsKey("selectedCountry")) {
      rxSelectedCountry.value = Countries.fromJson(args["selectedCountry"]);
    } else {}

    if (args.containsKey("number")) {
      rxNumber.value = args["number"];
    } else {}

    if (args.containsKey("email")) {
      rxEmail.value = args["email"];
    } else {}

    if (args.containsKey("isAPhoneNumber")) {
      rxIsAPhoneNumber.value = args["isAPhoneNumber"];
    } else {}

    return;
  }

  Future<void> getAppSignature() async {
    final String result = await SMSService().getAppSignature();
    log("App Signature: $result");

    return Future<void>.value();
  }

  bool validateForm() {
    const bool value = false;

    final bool result1 = rxOTP.value.isNotEmpty;
    if (!result1) {
      SnackBarUtil().show(LanguagesUtil().required);
      return value;
    }

    final bool result2 = rxOTP.value.length == 4;
    if (!result2) {
      SnackBarUtil().show(LanguagesUtil().otpValidationError);
      return value;
    }

    return result1 && result2;
  }

  Future<bool> resendOTP() async {
    final String dialCode = rxSelectedCountry.value.dialCode ?? "";
    final String number = rxNumber.value;
    final String email = rxEmail.value;
    final String signature = await SMSService().getAppSignature();

    final SendOTP result = await AuthRepository().sendOTP(<String, dynamic>{
      "method": rxIsAPhoneNumber.value ? "phone" : "email",
      "identifier": rxIsAPhoneNumber.value ? "$dialCode$number" : email,
      "app_signature": signature,
    });

    final bool value = !mapEquals(result.toJson(), SendOTP().toJson());

    return Future<bool>.value(value);
  }

  Future<void> verifyOTP() async {
    final String dialCode = rxSelectedCountry.value.dialCode ?? "";
    final String number = rxNumber.value;
    final String email = rxEmail.value;
    final String code = rxOTP.value;

    await SignInService().verify(
      method: rxIsAPhoneNumber.value ? "phone" : "email",
      identifier: rxIsAPhoneNumber.value ? "$dialCode$number" : email,
      code: code,
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
