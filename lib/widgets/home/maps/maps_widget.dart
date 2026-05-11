// ignore_for_file: avoid_redundant_argument_values

import "dart:developer";

import "package:connector/constants/strings_constants.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:horizon/functions/empty_functions.dart";
import "package:horizon/utils/overlays/custom_bottom_sheet.dart";
import "package:horizon/widgets/builders/custom_future_builder.dart";
import "package:horizon/widgets/containers/custom_card.dart";
import "package:horizon/widgets/containers/custom_container.dart";
import "package:horizon/widgets/texts/custom_text.dart";

enum MapStyle { standard, silver, retro, dark, night, aubergine }

Future<MapStyle> showMapStyleSheet({required MapStyle currentStyle}) async {
  MapStyle value = currentStyle;

  try {
    final MapStyle? result = await CustomBottomSheet().showRB(
      items: MapStyle.values,
      selectedItem: value,
    );
    value = result ?? value;
  } on Exception catch (error, stackTrace) {
    log("Exception", error: error, stackTrace: stackTrace);
  } finally {}

  return Future<MapStyle>.value(value);
}

class MapsWidget extends StatelessWidget {
  const MapsWidget({
    required this.rxMapStyle,
    this.onTap = emptyFutureFunction,
    super.key,
  });
  final Rx<MapStyle> rxMapStyle;
  final Future<void> Function() onTap;

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return sizedWidget(context);
    });
  }

  Widget sizedWidget(final BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(12.0);

    return SizedBox(
      height: kToolbarHeight * 6,
      width: double.infinity,
      child: CustomContainer(
        borderRadius: borderRadius,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: customFutureBuilder(context),
        ),
      ),
    );
  }

  Widget customFutureBuilder(final BuildContext context) {
    return CustomFutureBuilder<String>(
      future: loadString(),
      builder: (BuildContext context, String? style) {
        return style != null ? mainWidget(context, style) : const SizedBox();
      },
    );
  }

  Widget mainWidget(final BuildContext context, final String style) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: mapWidget(context, style)),
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          child: upperWidget(context, style),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: lowerWidget(context, style),
        ),
      ],
    );
  }

  Widget upperWidget(final BuildContext context, final String style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomCard(
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.24),
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on_outlined, size: 24),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: CustomText(
                              data: "Bangalore",
                              style: TextStyle(fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        data: "Physical Activity",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomCard(
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.24),
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.air_outlined, size: 24),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: CustomText(
                              data: "Air Quality",
                              style: TextStyle(fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        data: "Extremely Good",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        CustomCard(
          onTap: onTap,
          color: Theme.of(
            context,
          ).textTheme.bodyMedium?.color?.withValues(alpha: 0.24),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.more_vert_outlined, size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget lowerWidget(final BuildContext context, final String style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomCard(
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.24),
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.roundabout_right_outlined, size: 24),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: CustomText(
                              data: "Distance",
                              style: TextStyle(fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        data: "1000.00 KM",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomCard(
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.24),
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.access_time_outlined, size: 24),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: CustomText(
                              data: "Duration",
                              style: TextStyle(fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        data: "100:00 Hours",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CustomCard(
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withValues(alpha: 0.24),
            padding: const EdgeInsets.all(8.0),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.av_timer_outlined, size: 24),
                SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: CustomText(
                              data: "Average Pace",
                              style: TextStyle(fontWeight: FontWeight.normal),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      CustomText(
                        data: "6.00 KM/H",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget mapWidget(final BuildContext context, final String style) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return GoogleMap(
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      style: style,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          StringsConstants().defaultLat,
          StringsConstants().defaultLng,
        ),
        zoom: 13.0,
      ),
      polygons: <Polygon>{
        Polygon(
          polygonId: const PolygonId("territory"),
          points: StringsConstants().defaultPolygonPoints,
          strokeColor: primaryColor,
          fillColor: primaryColor.withValues(alpha: 0.24),
          strokeWidth: 2,
        ),
      },
    );
  }

  Future<String> loadString() async {
    String value = "";

    try {
      final String path = "assets/styles/${rxMapStyle.value.name}.json";
      value = await rootBundle.loadString(path);
    } on Exception catch (error, stackTrace) {
      log("Exception", error: error, stackTrace: stackTrace);
    } finally {}

    return Future<String>.value(value);
  }
}
