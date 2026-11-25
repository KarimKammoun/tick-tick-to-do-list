import 'dart:math' as math;

import 'package:flutter/painting.dart';

/// WCAG 2.1 contrast helpers.
///
/// Annexe D.2 requires a contrast ratio of at least 4.5:1 between text and
/// background. The token table of the annexe gives visual estimates, so a few
/// derived tokens are computed here instead of being hard-coded: the raw accent
/// colour stays the reference for the palette, while the value used for text
/// and filled buttons is nudged until it reaches the required ratio in both
/// themes.
abstract final class Contrast {
  /// Minimum ratio for normal sized text (WCAG AA).
  static const double minTextRatio = 4.5;

  /// Minimum ratio for icons and graphical objects (WCAG AA).
  static const double minGraphicRatio = 3;

  /// Relative luminance of a colour, as defined by WCAG 2.1.
  static double relativeLuminance(Color color) {
    double channel(double value) {
      return value <= 0.03928
          ? value / 12.92
          : math.pow((value + 0.055) / 1.055, 2.4).toDouble();
    }

    return 0.2126 * channel(color.r) +
        0.7152 * channel(color.g) +
        0.0722 * channel(color.b);
  }

  /// Contrast ratio between two opaque colours, between 1 and 21.
  static double ratio(Color a, Color b) {
    final double luminanceA = relativeLuminance(a);
    final double luminanceB = relativeLuminance(b);
    final double lighter = math.max(luminanceA, luminanceB);
    final double darker = math.min(luminanceA, luminanceB);
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Returns [foreground] when it already reaches [minRatio] on
  /// [background], otherwise blends it towards black or white - whichever
  /// direction leaves the background - until the ratio is met.
  static Color readable(Color foreground, Color background,
      {double minRatio = minTextRatio}) {
    final bool lighten = relativeLuminance(background) < 0.5;
    final Color target =
        lighten ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

    if (ratio(foreground, background) >= minRatio) {
      return foreground;
    }
    for (int step = 1; step <= 100; step++) {
      final Color candidate =
          Color.alphaBlend(target.withValues(alpha: step / 100), foreground);
      if (ratio(candidate, background) >= minRatio) {
        return candidate;
      }
    }
    return target;
  }

  /// Picks the lightest or darkest text colour for a filled background,
  /// preferring white (or the supplied dark) when both are acceptable.
  static Color textOn(
    Color background, {
    Color light = const Color(0xFFFFFFFF),
    Color dark = const Color(0xFF14171A),
  }) {
    final double lightRatio = ratio(light, background);
    final double darkRatio = ratio(dark, background);
    if (lightRatio >= minTextRatio && lightRatio >= darkRatio) {
      return light;
    }
    if (darkRatio >= minTextRatio) {
      return dark;
    }
    return lightRatio >= darkRatio ? light : dark;
  }

  /// Accent colour usable for text and filled surfaces: the raw accent is kept
  /// when it already carries white text *and* reads on the background,
  /// otherwise it is moved away from the background until both hold.
  static Color accessibleAccent(Color accent, Color background) {
    final bool isDarkBackground = relativeLuminance(background) < 0.5;
    final Color edge =
        isDarkBackground ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

    double score(Color color) {
      final Color onColor = textOn(color);
      return math.min(ratio(onColor, color), ratio(color, background));
    }

    if (score(accent) >= minTextRatio) {
      return accent;
    }
    for (int step = 1; step <= 100; step++) {
      final Color candidate =
          Color.alphaBlend(edge.withValues(alpha: step / 100), accent);
      if (score(candidate) >= minTextRatio) {
        return candidate;
      }
    }
    return edge;
  }
}
