import "package:connector/controllers/onboarding/your_details_controller.dart";
import "package:connector/functions/onboarding/astronomy_functions.dart";
import "package:connector/functions/onboarding/drink_functions.dart";
import "package:connector/functions/onboarding/gender_functions.dart";
import "package:connector/functions/onboarding/smoke_functions.dart";
import "package:connector/utils/languages_util.dart";
import "package:connector/widgets/cupertino_pickers/astronomy_picker.dart";
import "package:connector/widgets/cupertino_pickers/dob_picker.dart";
import "package:connector/widgets/cupertino_pickers/drink_picker.dart";
import "package:connector/widgets/cupertino_pickers/gender_picker.dart";
import "package:connector/widgets/cupertino_pickers/height_picker.dart";
import "package:connector/widgets/cupertino_pickers/smoke_picker.dart";
import "package:connector/widgets/cupertino_pickers/weight_picker.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:horizon/utils/min_max_length_input_formatter.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/buttons/custom_icon_button.dart";
import "package:horizon/widgets/buttons/custom_text_button.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/fields/custom_text_form_field.dart";
import "package:horizon/widgets/texts/custom_text.dart";
import "package:material_ui/material_ui.dart";

class YourDetailsScreen extends GetView<YourDetailsController> {
  const YourDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleAndSubtitleWidget(context),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GetBuilder<YourDetailsController>(
                    builder: (YourDetailsController controller) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 16),
                          firstNameFieldWidget(),
                          const SizedBox(height: 16),
                          lastNameFieldWidget(),
                          const SizedBox(height: 16),
                          userNameFieldWidget(),
                          const SizedBox(height: 16),
                          phoneNumberFieldWidget(context),
                          const SizedBox(height: 16),
                          emailFieldWidget(context),
                          const SizedBox(height: 16),
                          dateOfBirthWidget(),
                          const SizedBox(height: 16),
                          rowHeightWeightWidget(),
                          const SizedBox(height: 16),
                          rowGenderAstronomyWidget(),
                          const SizedBox(height: 16),
                          rowSmokeDrinkWidget(),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 0),
              nextButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleAndSubtitleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(
                  data: LanguagesUtil().yourDetails,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                CustomText(
                  data: LanguagesUtil().soWeCanPersonalise,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget firstNameFieldWidget() {
    return CustomTextFormField(
      controller: controller.firstNameController,
      onChanged: controller.rxFirstName.call,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[AutofillHints.givenName],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().firstName,
      hintText: LanguagesUtil().firstNameHint,
    );
  }

  Widget lastNameFieldWidget() {
    return CustomTextFormField(
      controller: controller.lastNameController,
      onChanged: controller.rxLastName.call,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[AutofillHints.familyName],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().lastName,
      hintText: LanguagesUtil().lastNameHint,
    );
  }

  Widget userNameFieldWidget() {
    return CustomTextFormField(
      controller: controller.usernameController,
      onChanged: controller.rxUsername.call,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[AutofillHints.username],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().username,
      hintText: LanguagesUtil().usernameHint,
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

  Widget emailFieldWidget(BuildContext context) {
    return CustomTextFormField(
      controller: controller.emailController,
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

  Widget dateOfBirthWidget() {
    return CustomContainer(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          CustomText(
            data: LanguagesUtil().dateOfBirth,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: kToolbarHeight * 2,
            width: double.infinity,
            child: Builder(
              builder: (BuildContext context) {
                final DateTime? v0 = controller.rxDateOfBirth.value;

                return DOBPicker(
                  key: ValueKey<dynamic>(v0),
                  initialDateTime: controller.rxDateOfBirth.value,
                  onDateTimeChanged: controller.setDateOfBirth,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget rowHeightWeightWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: heightWidget()),
        const SizedBox(width: 16),
        Expanded(child: weightWidget()),
      ],
    );
  }

  Widget heightWidget() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: CustomContainer(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 8),
                CustomText(
                  data: LanguagesUtil().height,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: kToolbarHeight * 2,
                  width: double.infinity,
                  child: Builder(
                    builder: (BuildContext context) {
                      final bool v0 = controller.rxIsHeightInFtIn.value;
                      final (int, int) v1 = controller.rxHeightInFt.value;
                      final int v2 = controller.rxHeightInCm.value;

                      return HeightPicker(
                        key: ValueKey<dynamic>("${v0}_${v1}_$v2"),
                        isHeightInFt: controller.rxIsHeightInFtIn.value,
                        heightInFt: controller.rxHeightInFt.value,
                        heightInCm: controller.rxHeightInCm.value,
                        onHeightChangedFt: controller.setHeightInFt,
                        onHeightChangedCm: controller.setHeightInCm,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: CustomIconButton(
            onPressed: () async {
              controller.toggleHeightUnit();
            },
            data: const Icon(Icons.sync, size: 16),
          ),
        ),
      ],
    );
  }

  Widget weightWidget() {
    return Stack(
      children: <Widget>[
        Positioned(
          child: CustomContainer(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 8),
                CustomText(
                  data: LanguagesUtil().weight,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: kToolbarHeight * 2,
                  width: double.infinity,
                  child: Builder(
                    builder: (BuildContext context) {
                      final bool v0 = controller.rxIsWeightInKg.value;
                      final int v1 = controller.rxWeightInKg.value;
                      final int v2 = controller.rxWeightInLb.value;

                      return WeightPicker(
                        key: ValueKey<dynamic>("${v0}_${v1}_$v2"),
                        isWeightInKg: controller.rxIsWeightInKg.value,
                        weightInKg: controller.rxWeightInKg.value,
                        weightInLb: controller.rxWeightInLb.value,
                        onWeightChangedKg: controller.setWeightInKg,
                        onWeightChangedLb: controller.setWeightInLb,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: CustomIconButton(
            onPressed: () async {
              controller.toggleWeightUnit();
            },
            data: const Icon(Icons.sync, size: 16),
          ),
        ),
      ],
    );
  }

  Widget rowGenderAstronomyWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: genderWidget()),
        const SizedBox(width: 16),
        Expanded(child: astronomyWidget()),
      ],
    );
  }

  Widget genderWidget() {
    return CustomContainer(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          CustomText(
            data: LanguagesUtil().gender,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: kToolbarHeight * 2,
            width: double.infinity,
            child: Builder(
              builder: (BuildContext context) {
                final GenderEnum v0 = controller.rxGender.value;

                return GenderPicker(
                  key: ValueKey<dynamic>(v0),
                  gender: controller.rxGender.value,
                  onGenderChanged: controller.setGender,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget astronomyWidget() {
    return CustomContainer(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          CustomText(
            data: LanguagesUtil().astronomy,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: kToolbarHeight * 2,
            width: double.infinity,
            child: Builder(
              builder: (BuildContext context) {
                final AstronomyEnum v0 = controller.rxAstronomy.value;

                return AstronomyPicker(
                  key: ValueKey<dynamic>(v0),
                  astronomy: controller.rxAstronomy.value,
                  onAstronomyChanged: controller.setAstronomy,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget rowSmokeDrinkWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: smokeWidget()),
        const SizedBox(width: 16),
        Expanded(child: drinkWidget()),
      ],
    );
  }

  Widget smokeWidget() {
    return CustomContainer(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          CustomText(
            data: LanguagesUtil().smoke,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: kToolbarHeight * 2,
            width: double.infinity,
            child: Builder(
              builder: (BuildContext context) {
                final SmokeEnum v0 = controller.rxSmoke.value;

                return SmokePicker(
                  key: ValueKey<dynamic>(v0),
                  smoke: controller.rxSmoke.value,
                  onSmokeChanged: controller.setSmoke,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget drinkWidget() {
    return CustomContainer(
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 8),
          CustomText(
            data: LanguagesUtil().drink,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: kToolbarHeight * 2,
            width: double.infinity,
            child: Builder(
              builder: (BuildContext context) {
                final DrinkEnum v0 = controller.rxDrink.value;

                return DrinkPicker(
                  key: ValueKey<dynamic>(v0),
                  drink: controller.rxDrink.value,
                  onDrinkChanged: controller.setDrink,
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget nextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: CustomContainer(
            borderRadius: BorderRadius.circular(24),
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            onTap: controller.navigate,
            child: CustomText(
              data: LanguagesUtil().next,
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
