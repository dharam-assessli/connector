import "package:connector/controllers/onboarding/your_details_controller.dart";
import "package:connector/utils/languages_util.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:horizon/utils/min_max_length_input_formatter.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
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
                      return Obx(() {
                        return Form(
                          key: controller.formKey,
                          child: Column(
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
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 0),
              continueButton(),
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
        // final String text = (value ?? "").trim();
        // return text.isEmpty
        //     ? LanguagesUtil().required
        //     : text.length < controller.minLength
        //     ? LanguagesUtil().phoneNumberValidationError
        //     : null;

        //
        // TODO(souvik): Temporarily disabled validation.
        return null;
        //
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
    return CustomTextFormField(
      controller: controller.dateOfBirthController,
      onChanged: controller.rxDateOfBirthString.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[AutofillHints.birthdayDay],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().dateOfBirth,
      hintText: LanguagesUtil().dateOfBirthHint,
      readOnly: true,
      onTap: controller.onTapDOB,
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
    return CustomTextFormField(
      controller: controller.heightController,
      onChanged: controller.rxHeight.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().height,
      hintText: LanguagesUtil().heightHint,
      readOnly: true,
      onTap: controller.onTapHeight,
    );
  }

  Widget weightWidget() {
    return CustomTextFormField(
      controller: controller.weightController,
      onChanged: controller.rxWeight.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().weight,
      hintText: LanguagesUtil().weightHint,
      readOnly: true,
      onTap: controller.onTapWeight,
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
    return CustomTextFormField(
      controller: controller.genderController,
      onChanged: controller.rxGenderString.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().gender,
      hintText: LanguagesUtil().genderHint,
      readOnly: true,
      onTap: controller.onTapGender,
    );
  }

  Widget astronomyWidget() {
    return CustomTextFormField(
      controller: controller.astronomyController,
      onChanged: controller.rxAstronomyString.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().astronomy,
      hintText: LanguagesUtil().astronomyHint,
      readOnly: true,
      onTap: controller.onTapAstronomy,
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
    return CustomTextFormField(
      controller: controller.smokeController,
      onChanged: controller.rxSmokeString.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().smoke,
      hintText: LanguagesUtil().smokeHint,
      readOnly: true,
      onTap: controller.onTapSmoke,
    );
  }

  Widget drinkWidget() {
    return CustomTextFormField(
      controller: controller.drinkController,
      onChanged: controller.rxDrinkString.call,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (String? value) {
        final String text = (value ?? "").trim();
        return text.isEmpty ? LanguagesUtil().required : null;
      },
      autofillHints: const <String>[],
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      labelText: LanguagesUtil().drink,
      hintText: LanguagesUtil().drinkHint,
      readOnly: true,
      onTap: controller.onTapDrink,
    );
  }

  Widget continueButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: CustomContainer(
            borderRadius: BorderRadius.circular(24),
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            onTap: () async {
              final bool isValid = controller.validateForm();

              if (!isValid) {
                return Future<void>.value();
              } else {}

              final bool setUser = await controller.setUser();

              if (!setUser) {
                return Future<void>.value();
              } else {}

              // navigate to the appropriate screen based on the nav source.
              await controller.navigate();
            },
            child: CustomText(
              data: LanguagesUtil().continueText,
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
