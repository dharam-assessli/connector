import "dart:async";

import "package:connector/utils/languages_util.dart";
import "package:connector/utils/routes_utils.dart";
import "package:cross_file/cross_file.dart";
import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:horizon/functions/astronomy_functions.dart";
import "package:horizon/functions/drink_functions.dart";
import "package:horizon/functions/gender_functions.dart";
import "package:horizon/functions/height_functions.dart";
import "package:horizon/functions/smoke_functions.dart";
import "package:horizon/functions/weight_functions.dart";
import "package:horizon/models/auth/get_set_user.dart";
import "package:horizon/models/auth/user.dart";
import "package:horizon/models/countries/countries.dart";
import "package:horizon/services/country_find_service.dart";
import "package:horizon/services/identify_service.dart";
import "package:horizon/services/jwt/auth_db_service.dart";
import "package:horizon/services/jwt/user_refresh_service.dart";
import "package:horizon/services/navigation_service.dart";
import "package:horizon/utils/bottom_sheets/countries_sheet.dart";
import "package:horizon/utils/overlays/snack_bar_util.dart";

enum NavigationSource { verify, home }

class YourDetailsController extends GetxController {
  final Rx<NavigationSource> rxNavigationSource = NavigationSource.verify.obs;

  final RxString rxId = "".obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Rx<XFile> rxProfilePictureXFile = XFile("").obs;
  final RxString rxProfilePicturePath = "".obs;

  final TextEditingController firstNameController = TextEditingController();
  final RxString rxFirstName = "".obs;

  final TextEditingController lastNameController = TextEditingController();
  final RxString rxLastName = "".obs;

  final TextEditingController usernameController = TextEditingController();
  final RxString rxUsername = "".obs;

  final Rx<Countries> rxSelectedCountry = Countries(
    name: "United States",
    code: "US",
    dialCode: "+1",
    flag: "🇺🇸",
    minLength: 10,
    maxLength: 10,
  ).obs;

  final TextEditingController numberTextController = TextEditingController();
  final RxString rxNumber = "".obs;
  final RxBool rxIsPhoneVerified = false.obs;

  final TextEditingController emailController = TextEditingController();
  final RxString rxEmail = "".obs;
  final RxBool rxIsEmailVerified = false.obs;

  final Rx<DateTime> rxDateOfBirth = DateTime(DateTime.now().year - 18).obs;

  final RxBool rxIsHeightInFtIn = true.obs;
  final Rx<(int, int)> rxHeightInFt = defaultHeightFt.obs;
  final RxInt rxHeightInCm = defaultHeightCm.obs;

  final RxBool rxIsWeightInKg = true.obs;
  final RxInt rxWeightInKg = defaultWeightKg.obs;
  final RxInt rxWeightInLb = defaultWeightLb.obs;

  final Rx<GenderEnum> rxGender = defaultGender.obs;

  final Rx<AstronomyEnum> rxAstronomy = defaultAstronomy.obs;

  final Rx<SmokeEnum> rxSmoke = defaultSmoke.obs;

  final Rx<DrinkEnum> rxDrink = defaultDrink.obs;

  void setDateOfBirth(DateTime date) {
    rxDateOfBirth.value = date;

    return;
  }

  void toggleHeightUnit() {
    rxIsHeightInFtIn.value = !rxIsHeightInFtIn.value;

    update();

    return;
  }

  void setHeightInFt((int, int) height) {
    rxHeightInFt.value = height;
    rxHeightInCm.value = ftToCm(height);

    return;
  }

  void setHeightInCm(int height) {
    rxHeightInCm.value = height;
    rxHeightInFt.value = cmToFt(height);

    return;
  }

  void toggleWeightUnit() {
    rxIsWeightInKg.value = !rxIsWeightInKg.value;

    update();

    return;
  }

  void setWeightInKg(int weight) {
    rxWeightInKg.value = weight;
    rxWeightInLb.value = kgToLb(weight);

    return;
  }

  void setWeightInLb(int weight) {
    rxWeightInLb.value = weight;
    rxWeightInKg.value = lbToKg(weight);

    return;
  }

  void setGender(GenderEnum gender) {
    rxGender.value = gender;

    return;
  }

  void setAstronomy(AstronomyEnum astronomy) {
    rxAstronomy.value = astronomy;

    return;
  }

  void setSmoke(SmokeEnum smoke) {
    rxSmoke.value = smoke;

    return;
  }

  void setDrink(DrinkEnum drink) {
    rxDrink.value = drink;

    return;
  }

  void setCountryCode([Countries? selected]) {
    final Countries result = selected ?? CountryFindService().find();

    rxSelectedCountry.value = result;

    return;
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

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> args = Get.arguments as Map<String, dynamic>;

      if (args.containsKey("navigationSource")) {
        rxNavigationSource.value = NavigationSource.values.firstWhere(
          (NavigationSource e) {
            return args["navigationSource"] == e.name;
          },
          orElse: () {
            return NavigationSource.verify;
          },
        );
      } else {}
    }
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await getUser();
  }

  Future<bool> getUser() async {
    final GetSetUser user = await UserRefreshService().getUser();

    await setData(user.user ?? User());

    return Future<bool>.value(!mapEquals(user.toJson(), GetSetUser().toJson()));
  }

  Future<bool> setUser() async {
    final Map<String, dynamic> body = buildJSON();

    final GetSetUser user = await UserRefreshService().setUser(body);

    return Future<bool>.value(!mapEquals(user.toJson(), GetSetUser().toJson()));
  }

  Future<void> setData(User user) async {
    rxId.value = user.id ?? "";

    rxProfilePictureXFile.value = XFile("");
    rxProfilePicturePath.value = user.avatarUrl ?? "";

    firstNameController.text = user.firstName ?? "";
    rxFirstName.value = user.firstName ?? "";

    lastNameController.text = user.lastName ?? "";
    rxLastName.value = user.lastName ?? "";

    usernameController.text = user.displayName ?? "";
    rxUsername.value = user.displayName ?? "";

    await read(user.phoneE164 ?? "");
    rxIsPhoneVerified.value = user.isPhoneVerified ?? false;

    emailController.text = user.email ?? "";
    rxEmail.value = user.email ?? "";
    rxIsEmailVerified.value = user.isEmailVerified ?? false;

    setDateOfBirth(
      (user.dateOfBirth != null) && ((user.dateOfBirth ?? "").isNotEmpty)
          ? DateTime.tryParse(user.dateOfBirth ?? "") ?? rxDateOfBirth.value
          : rxDateOfBirth.value,
    );

    rxIsHeightInFtIn.value = true;
    final List<String> heightInFt = (user.heightInFt ?? 0).toString().split(
      ".",
    );
    setHeightInFt((
      heightInFt.asMap().containsKey(0)
          ? (int.tryParse(heightInFt[0]) ?? defaultHeightFt.$1)
          : defaultHeightFt.$1,
      heightInFt.asMap().containsKey(1)
          ? (int.tryParse(heightInFt[1]) ?? defaultHeightFt.$2)
          : defaultHeightFt.$2,
    ));
    setHeightInCm((user.heightInCm ?? defaultHeightCm).toInt());

    rxIsWeightInKg.value = true;
    setWeightInKg((user.weightInKg ?? defaultWeightKg).toInt());
    setWeightInLb((user.weightInLb ?? defaultWeightLb).toInt());

    setGender(
      GenderEnum.values.firstWhere(
        (GenderEnum e) {
          return (user.gender ?? "") == e.name;
        },
        orElse: () {
          return defaultGender;
        },
      ),
    );

    setAstronomy(
      AstronomyEnum.values.firstWhere(
        (AstronomyEnum e) {
          return (user.zodiacSign ?? "") == e.name;
        },
        orElse: () {
          return defaultAstronomy;
        },
      ),
    );

    setSmoke(
      SmokeEnum.values.firstWhere(
        (SmokeEnum e) {
          return (user.smoke ?? "") == e.name;
        },
        orElse: () {
          return defaultSmoke;
        },
      ),
    );

    setDrink(
      DrinkEnum.values.firstWhere(
        (DrinkEnum e) {
          return (user.drink ?? "") == e.name;
        },
        orElse: () {
          return defaultDrink;
        },
      ),
    );

    update();

    return Future<void>.value();
  }

  bool validateForm() {
    const bool value = false;

    final bool result1 = formKey.currentState?.validate() ?? false;
    if (!result1) {
      SnackBarUtil().show(LanguagesUtil().pleaseFillAllFields);
      return value;
    }

    return result1;
  }

  Map<String, dynamic> buildJSON() {
    final User user = User(
      id: rxId.value,
      email: rxEmail.value,
      isEmailVerified: rxIsEmailVerified.value,
      phoneE164: "${rxSelectedCountry.value.dialCode ?? ""}${rxNumber.value}",
      isPhoneVerified: rxIsPhoneVerified.value,
      firstName: rxFirstName.value,
      lastName: rxLastName.value,
      dateOfBirth: rxDateOfBirth.value.toIso8601String(),
      displayName: rxUsername.value,
      heightInFt: double.parse(
        "${rxHeightInFt.value.$1}.${rxHeightInFt.value.$2}",
      ),
      heightInCm: double.parse("${rxHeightInCm.value}"),
      weightInKg: double.parse("${rxWeightInKg.value}"),
      weightInLb: double.parse("${rxWeightInLb.value}"),
      gender: rxGender.value.name,
      zodiacSign: rxAstronomy.value.name,
      smoke: rxSmoke.value.name,
      drink: rxDrink.value.name,
      metadata: AuthDBService().user.metadata,
      avatarUrl: AuthDBService().user.avatarUrl,
      bio: AuthDBService().user.bio,
      timezone: AuthDBService().user.timezone,
      locale: AuthDBService().user.locale,
      role: AuthDBService().user.role,
      isActive: AuthDBService().user.isActive,
      creditBalance: AuthDBService().user.creditBalance,
      createdAt: AuthDBService().user.createdAt,
      updatedAt: AuthDBService().user.updatedAt,
    );

    return user.toJson();
  }

  Future<void> navigate() async {
    switch (rxNavigationSource.value) {
      case NavigationSource.verify:
        await NavigationService().pushNamedAndRemoveUntil(
          RoutesUtils().dashboardScreen,
          arguments: <String, dynamic>{},
          circularTransition: true,
        );
        break;

      case NavigationSource.home:
        NavigationService().pop();
        break;
    }

    return Future<void>.value();
  }
  //
}
