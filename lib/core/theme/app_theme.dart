import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_theme_extension.dart';
import 'contrast.dart';

/// Builds the light and dark [ThemeData] from the Annexe D colour tokens.
///
/// Both themes share the same component recipes; only the tokens differ, so no
/// screen ever needs to know which theme is active.
abstract final class AppTheme {
  /// Light theme built from the Annexe D.2 light tokens.
  static ThemeData light(Color accent) =>
      _build(AppColors.light().harmonized(accent));

  /// Dark theme built from the Annexe D.2 dark tokens.
  static ThemeData dark(Color accent) =>
      _build(AppColors.dark().harmonized(accent));

  static ThemeData _build(AppColors colors) {
    final Color accent = colors.accentedColor;
    final Brightness brightness =
        colors.brightnessIsDark ? Brightness.dark : Brightness.light;

    final ColorScheme scheme = ColorScheme(
      brightness: brightness,
      primary: accent,
      onPrimary: _readableOn(accent),
      primaryContainer: Color.alphaBlend(
        accent.withValues(alpha: colors.brightnessIsDark ? 0.28 : 0.14),
        colors.surface,
      ),
      onPrimaryContainer: colors.textPrimary,
      secondary: colors.success,
      onSecondary: _readableOn(colors.success),
      tertiary: colors.premium,
      onTertiary: _readableOn(colors.premium),
      error: colors.danger,
      onError: _readableOn(colors.danger),
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      surfaceContainerHighest: colors.input,
      outline: colors.divider,
      outlineVariant: colors.divider,
      shadow: colors.overlay,
      scrim: colors.overlay,
    );

    final TextTheme textTheme = _textTheme(colors);

    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      dividerColor: colors.divider,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[AppColorsTheme(colors)],
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarThemeData(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme:
            IconThemeData(color: colors.textPrimary, size: AppSizes.icon),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),
      iconTheme:
          IconThemeData(color: colors.textSecondary, size: AppSizes.icon),
      listTileTheme: ListTileThemeData(
        iconColor: colors.textSecondary,
        textColor: colors.textPrimary,
        selectedColor: accent,
        selectedTileColor: colors.selected,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        elevation: 0,
        height: AppSizes.bottomBarHeight,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          return IconThemeData(
            size: AppSizes.icon,
            color: states.contains(WidgetState.selected)
                ? accent
                : colors.textSecondary,
          );
        }),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.rail,
        indicatorColor: Colors.transparent,
        selectedIconTheme: IconThemeData(color: colors.onRail),
        unselectedIconTheme: IconThemeData(
          color: colors.onRail.withValues(alpha: 0.65),
        ),
        labelType: NavigationRailLabelType.none,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: _readableOn(accent),
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheet),
        dragHandleColor: colors.divider,
        barrierColor: colors.overlay,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: colors.input,
        hintStyle: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.card,
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.card,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.card,
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: accent),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: _readableOn(accent),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.brightnessIsDark
            ? colors.surface
            : colors.textPrimary,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colors.brightnessIsDark ? colors.textPrimary : colors.surface,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colors.surfaceSidebar,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
        textStyle: textTheme.bodyMedium,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: accent),
    );
  }

  static TextTheme _textTheme(AppColors colors) {
    final TextTheme base = Typography.material2021().black;
    return base
        .apply(bodyColor: colors.textPrimary, displayColor: colors.textPrimary)
        .copyWith(
          titleLarge: base.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
          titleMedium: base.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
          bodyLarge: base.bodyLarge?.copyWith(
            fontSize: 15,
            color: colors.textPrimary,
          ),
          bodyMedium: base.bodyMedium?.copyWith(
            fontSize: 14,
            color: colors.textPrimary,
          ),
          bodySmall: base.bodySmall?.copyWith(
            fontSize: 12,
            color: colors.textSecondary,
          ),
          labelSmall: base.labelSmall?.copyWith(
            fontSize: 11,
            color: colors.textSecondary,
          ),
        );
  }

  /// Picks the text colour for a filled background with the WCAG ratio of
  /// Annexe D.2 (at least 4.5:1).
  static Color _readableOn(Color background) =>
      Contrast.textOn(background, dark: const Color(0xFF1A1C1E));
}
