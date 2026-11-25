import 'package:flutter/widgets.dart';

/// Spacing, radius and layout tokens.
///
/// Annexe D forbids hard-coded dimensions in screens; use these tokens.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Horizontal padding of a screen body.
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
}

/// Corner radius tokens (Annexe D: rounded cards, rounded bottom sheets).
abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;

  static const BorderRadius card = BorderRadius.all(Radius.circular(md));
  static const BorderRadius sheet =
      BorderRadius.vertical(top: Radius.circular(xl));
  static const BorderRadius checkbox = BorderRadius.all(Radius.circular(xs));
}

/// Responsive breakpoints of the application shell.
abstract final class AppBreakpoints {
  /// Below this width the shell uses the mobile layout (bottom bar).
  static const double mobile = 700;

  /// Above this width the shell uses the four-zone desktop layout.
  static const double desktop = 1000;
}

/// Fixed sizes shared by the shell and the base components.
abstract final class AppSizes {
  static const double bottomBarHeight = 56;
  static const double railWidth = 64;
  static const double sidebarWidth = 248;
  static const double detailPanelWidth = 340;
  static const double checkboxSize = 20;
  static const double iconSmall = 18;
  static const double icon = 24;
  static const double fabSize = 56;
  static const double sheetHandleWidth = 36;
  static const double sheetHandleHeight = 4;
  static const double accentSwatch = 40;
  static const double emptyStateIcon = 48;
  static const double accentSwatchSelected = 24;
}
