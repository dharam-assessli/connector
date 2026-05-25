import "dart:io";

import "package:connector/controllers/sync/manual_sync_controller.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart";
import "package:get/get.dart";
import "package:horizon/functions/date_time_functions.dart";
import "package:horizon/widgets/animations/animated_gradient.dart";
import "package:horizon/widgets/app_bar/custom_app_bar.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/fields/custom_text_form_field.dart";
import "package:horizon/widgets/texts/custom_text.dart";

class ManualSyncScreen extends GetView<ManualSyncController> {
  const ManualSyncScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: AnimatedGradient(child: SafeArea(child: mainWidget(context))),
    );
  }

  Widget mainWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextFormField(
                controller: TextEditingController(
                  text: formatUtcToLocal(
                    controller.rxStrDateTime.value.toIso8601String(),
                  ),
                ),
                onChanged: (String p0) {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  return null;
                },
                autofillHints: const <String>[],
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                labelText: "Start Date and Time",
                hintText: "Select",
                readOnly: true,
                onTap: () {
                  showDateTimePicker(
                    context: context,
                    dateTime: controller.rxStrDateTime.value,
                    onConfirm: (DateTime dateTime) async {
                      controller.updateStrDateTime(dateTime);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: TextEditingController(
                  text: formatUtcToLocal(
                    controller.rxEndDateTime.value.toIso8601String(),
                  ),
                ),
                onChanged: (String p0) {},
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  return null;
                },
                autofillHints: const <String>[],
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
                labelText: "End Date and Time",
                hintText: "Select",
                readOnly: true,
                onTap: () {
                  showDateTimePicker(
                    context: context,
                    dateTime: controller.rxEndDateTime.value,
                    onConfirm: (DateTime dateTime) async {
                      controller.updateEndDateTime(dateTime);
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CustomContainer(
                      padding: const EdgeInsets.all(16),
                      onTap: controller.syncLocationData,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.sync, size: 16.0),
                          SizedBox(width: 8),
                          CustomText(
                            data: "Location",
                            style: TextStyle(fontSize: 12.0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomContainer(
                      padding: const EdgeInsets.all(16),
                      onTap: controller.syncHealthData,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.sync, size: 16.0),
                          SizedBox(width: 8),
                          CustomText(
                            data: "Health",
                            style: TextStyle(fontSize: 12.0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (Platform.isAndroid) const SizedBox(width: 8),
                  if (Platform.isAndroid)
                    Expanded(
                      child: CustomContainer(
                        padding: const EdgeInsets.all(16),
                        onTap: controller.syncScreenData,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.sync, size: 16.0),
                            SizedBox(width: 8),
                            CustomText(
                              data: "Screen",
                              style: TextStyle(fontSize: 12.0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  void showDateTimePicker({
    required BuildContext context,
    required DateTime dateTime,
    required Function(DateTime) onConfirm,
  }) {
    return DatePicker.showDatePicker(
      context,
      minDateTime: DateTime.now().subtract(const Duration(days: 365)),
      maxDateTime: DateTime.now(),
      initialDateTime: dateTime,
      dateFormat: "dd-MM-yyyy HH:mm",
      pickerMode: DateTimePickerMode.datetime,
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        onConfirm(dateTime);
      },
    );
  }
}
