import 'dart:ui' show Color;

import 'contrast.dart';

/// Colour tokens of Annexe D.2.
///
/// Screens must never contain a literal colour: every colour comes from
/// [AppColors] (through the theme extension) or from [ColorScheme].
///
/// The values are the light `[0]` and dark `[1]` columns of the Annexe D.2
/// table, in that order.
class AppColors {
  const AppColors({
    required this.brightnessIsDark,
    required this.background,
    required this.surface,
    required this.surfaceSidebar,
    required this.rail,
    required this.onRail,
    required this.selected,
    required this.input,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.overlay,
    required this.danger,
    required this.success,
    required this.premium,
    required this.priorityHigh,
    required this.priorityMedium,
    required this.priorityLow,
    required this.priorityNone,
    this.accentedColor = defaultAccent,
  });

  /// Light theme tokens (Annexe D.2, colonne « Clair »).
  factory AppColors.light() => const AppColors(
        brightnessIsDark: false,
        background: Color(0xFFF1F3F9),
        surface: Color(0xFFFFFFFF),
        surfaceSidebar: Color(0xFFF5F6FA),
        rail: Color(0xFF1F3FA8),
        onRail: Color(0xFFFFFFFF),
        selected: Color(0xFFEDEFFB),
        input: Color(0xFFF1F3F9),
        textPrimary: Color(0xFF1A1C1E),
        textSecondary: Color(0xFF6B7280),
        divider: Color(0xFFE5E7EB),
        overlay: Color(0x59000000),
        danger: Color(0xFFD52B24),
        success: Color(0xFF2E9E5B),
        premium: Color(0xFFF59E0B),
        priorityHigh: Color(0xFFD52B24),
        priorityMedium: Color(0xFFF2B01E),
        priorityLow: Color(0xFF4772FA),
        priorityNone: Color(0xFFB5B8BD),
      );

  /// Dark theme tokens (Annexe D.2, colonne « Sombre »).
  factory AppColors.dark() => const AppColors(
        brightnessIsDark: true,
        background: Color(0xFF14171A),
        surface: Color(0xFF1D2125),
        surfaceSidebar: Color(0xFF1F2428),
        rail: Color(0xFF1B3A44),
        onRail: Color(0xFFE8EAED),
        selected: Color(0xFF2B3136),
        input: Color(0xFF272C30),
        textPrimary: Color(0xFFE8EAED),
        textSecondary: Color(0xFF9AA0A6),
        divider: Color(0xFF2E3338),
        overlay: Color(0x8C000000),
        danger: Color(0xFFE5484D),
        success: Color(0xFF3DBE74),
        premium: Color(0xFFF59E0B),
        priorityHigh: Color(0xFFE5484D),
        priorityMedium: Color(0xFFF2B01E),
        priorityLow: Color(0xFF6A8DFF),
        priorityNone: Color(0xFF6B7280),
      );

  /// True when these tokens describe the dark theme.
  final bool brightnessIsDark;

  /// Screen background.
  final Color background;

  /// Cards, PC list and detail panels.
  final Color surface;

  /// PC sidebar.
  final Color surfaceSidebar;

  /// PC icon rail (tinted with the accent colour for custom accents).
  final Color rail;

  /// Foreground on [rail].
  final Color onRail;

  /// Selected row / hovered row.
  final Color selected;

  /// "Add task" text field.
  final Color input;

  final Color textPrimary;
  final Color textSecondary;
  final Color divider;

  /// Scrim behind bottom sheets and dialogs.
  final Color overlay;

  final Color danger;
  final Color success;
  final Color premium;

  final Color priorityHigh;
  final Color priorityMedium;
  final Color priorityLow;
  final Color priorityNone;

  /// Accent colours offered in Settings > Appearance (Annexe D.3, palette of
  /// 8 colours, blue default and turquoise option).
  static const List<Color> accentPalette = <Color>[
    Color(0xFF4772FA),
    Color(0xFF3FA796),
    Color(0xFF7C5CFC),
    Color(0xFF2E9E5B),
    Color(0xFFF59E0B),
    Color(0xFFE5484D),
    Color(0xFFEC6FA8),
    Color(0xFF6B7280),
  ];

  /// Default accent colour, Annexe D.1.
  static const Color defaultAccent = Color(0xFF4772FA);

  /// Returns the tokens actually used by the theme and the screens.
  ///
  /// The palette above is the Annexe D.2 table verbatim. Three families of
  /// colours are then adjusted, without changing their hue, so that the 4.5:1
  /// requirement written in the same annexe always holds:
  ///
  /// * [textSecondary] - the light grey `#6B7280` only reaches 4.36:1 on the
  ///   `#F1F3F9` background, so it is darkened until it reaches 4.5:1;
  /// * the priority borders - they are drawn on the surface and must reach the
  ///   3:1 graphic contrast, which amber `#F2B01E` does not on white;
  /// * the accent, through [Contrast.accessibleAccent], so that white (light
  ///   theme) or dark (dark theme) text stays readable on the filled buttons
  ///   and the accent still reads on the background.
  ///
  /// [rail] is tinted from the accent, as specified in the annexe table where
  /// the rail is "accent foncé" in the light theme; the tint is adjusted with
  /// [Contrast.backgroundFor] so that the icons drawn on it stay readable.
  AppColors harmonized(Color accent) {
    final Color resolvedAccent = Contrast.accessibleAccent(accent, background);
    // A custom accent tints the rail, but never at the cost of readability:
    // the tint is darkened or lightened until the icons and labels drawn on the
    // rail reach the 4.5:1 ratio of Annexe D.2.
    final Color tintedRail = Color.alphaBlend(
      accent.withValues(alpha: brightnessIsDark ? 0.32 : 0.86),
      brightnessIsDark ? const Color(0xFF101314) : const Color(0xFF000000),
    );
    final Color railColor = accent == defaultAccent
        ? rail
        : Contrast.backgroundFor(onRail, tintedRail);

    return AppColors(
      brightnessIsDark: brightnessIsDark,
      background: background,
      surface: surface,
      surfaceSidebar: surfaceSidebar,
      rail: railColor,
      onRail: Contrast.readable(onRail, railColor),
      selected: accent == defaultAccent
          ? selected
          : Color.alphaBlend(accent.withValues(alpha: 0.18), surface),
      input: input,
      textPrimary: Contrast.readable(textPrimary, background),
      textSecondary: Contrast.readable(textSecondary, background),
      divider: divider,
      overlay: overlay,
      danger: Contrast.readable(danger, background),
      success: Contrast.readable(success, background),
      premium: Contrast.readable(premium, background),
      priorityHigh: Contrast.readable(priorityHigh, surface,
          minRatio: Contrast.minGraphicRatio),
      priorityMedium: Contrast.readable(priorityMedium, surface,
          minRatio: Contrast.minGraphicRatio),
      priorityLow: Contrast.readable(priorityLow, surface,
          minRatio: Contrast.minGraphicRatio),
      priorityNone: Contrast.readable(priorityNone, surface,
          minRatio: Contrast.minGraphicRatio),
      accentedColor: resolvedAccent,
    );
  }

  /// Accent colour after the contrast adjustment of [harmonized]; this is the
  /// colour used by the theme's `primary`, the FABs and the filled buttons.
  final Color accentedColor;
}
