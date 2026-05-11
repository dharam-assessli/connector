import "package:flutter/material.dart";

class GradientSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientSliderTrackShape({
    required this.gradient,
    required this.fallbackInactiveColor,
  });

  final Gradient gradient;
  final Color fallbackInactiveColor;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Radius radius = Radius.circular(trackRect.height / 2);

    final Paint inactivePaint = Paint()..color = fallbackInactiveColor;
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        topRight: radius,
        bottomRight: radius,
      ),
      inactivePaint,
    );

    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeRect);
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        activeRect.left,
        activeRect.top,
        activeRect.right,
        activeRect.bottom,
        topLeft: radius,
        bottomLeft: radius,
      ),
      activePaint,
    );
  }
}
