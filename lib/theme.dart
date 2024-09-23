import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282214456),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4290703538),
      onPrimaryContainer: Color(4278198786),
      secondary: Color(4283654990),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292274382),
      onSecondaryContainer: Color(4279312143),
      tertiary: Color(4281886057),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4290571247),
      onTertiaryContainer: Color(4278198306),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294441969),
      onSurface: Color(4279835927),
      background: Color(4294967295), // Background color is required
      onBackground: Color(4279835927), // onBackground color is required
      surfaceTint: Color(4282214456),
      outline: Color(4285757806),
      shadow: Color(4278190080),
      inverseSurface: Color(4281152043),
      inversePrimary: Color(4288926616),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288926616),
      onPrimary: Color(4279121933),
      primaryContainer: Color(4280700962),
      onPrimaryContainer: Color(4290703538),
      secondary: Color(4290432178),
      onSecondary: Color(4280693794),
      secondaryContainer: Color(4282141496),
      onSecondaryContainer: Color(4292274382),
      tertiary: Color(4288729043),
      onTertiary: Color(4278203962),
      tertiaryContainer: Color(4280175953),
      onTertiaryContainer: Color(4290571247),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309327),
      onSurface: Color(4292928730),
      background: Color(4278190080), // Background color is required
      onBackground: Color(4294967295), // onBackground color is required
      surfaceTint: Color(4288926616),
      outline: Color(4287402888),
      shadow: Color(4278190080),
      inverseSurface: Color(4292928730),
      inversePrimary: Color(4282214456),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
