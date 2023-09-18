import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';

enum DarkOption { dynamic, alwaysOn, alwaysOff }

class AppTheme {
  ///Default font
  static const String defaultFont = "Raleway";

  ///List Font support
  static final List<String> fontSupport = [
    "OpenSans",
    "Raleway",
    "Roboto",
    "Merriweather",
  ];

  ///Default Theme
  static final ThemeModel defaultTheme = ThemeModel.fromJson({
    "name": "default",
    "primary": 'ffe5634d',
    "secondary": "ff4a91a4",
  });

  ///List Theme Support in Application
  static final List themeSupport = [
    {
      "name": "default",
      "primary": 'ffe5634d',
      "secondary": "ff4a91a4",
    },
    {
      "name": "green",
      "primary": 'ff82B541',
      "secondary": "ffff8a65",
    },
    {
      "name": "orange",
      "primary": 'fff4a261',
      "secondary": "ff2A9D8F",
    }
  ].map((item) => ThemeModel.fromJson(item)).toList();

  ///Dark Theme option
  static DarkOption darkThemeOption = DarkOption.dynamic;

  ///Get theme data
  static ThemeData getTheme({
    required ThemeModel theme,
    required Brightness brightness,
    String? font,
  }) {
    ColorScheme colorScheme = ColorScheme.light(
      primary: theme.primary,
      secondary: theme.secondary,
      background: const Color.fromRGBO(249, 249, 249, 1),
      error: Colors.red,
    );
    if (brightness == Brightness.dark) {
      colorScheme = ColorScheme.dark(
        primary: theme.primary,
        secondary: theme.secondary,
        background: const Color.fromRGBO(23, 24, 25, 1),
      );
    }

    final bool isDark = colorScheme.brightness == Brightness.dark;

    final primary = isDark ? colorScheme.surface : colorScheme.primary;
    final onPrimary = isDark ? colorScheme.onSurface : colorScheme.onPrimary;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: colorScheme.brightness,
      primaryColor: primary,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      dialogBackgroundColor: colorScheme.background,
      indicatorColor: onPrimary,
      applyElevationOverlayColor: isDark,

      ///Custom
      fontFamily: font,
      dividerTheme: DividerThemeData(
        thickness: 0.8,
        color: colorScheme.onSurface.withOpacity(0.12),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primary.withOpacity(0.12),
        side: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.12),
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        showUnselectedLabels: true,
      ),
    );
  }

  ///export language dark option
  static String langDarkOption(DarkOption option) {
    switch (option) {
      case DarkOption.dynamic:
        return "dynamic_theme";
      case DarkOption.alwaysOff:
        return "always_off";
      default:
        return "always_on";
    }
  }

  ///Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
