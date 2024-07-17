import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xFF4700CC),
      surfaceTint: Color(0xff6326ff),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6c3cff),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5c0dd7),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff824afd),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff68529a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffceb8ff),
      onTertiaryContainer: Color(0xff3c266c),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffdf8ff),
      onBackground: Color(0xff1c1a25),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff1c1a25),
      surfaceVariant: Color(0xffe5e1e8),
      onSurfaceVariant: Color(0xff48464c),
      outline: Color(0xff79767c),
      outlineVariant: Color(0xffc9c5cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f3b),
      inverseOnSurface: Color(0xfff4eefe),
      inversePrimary: Color(0xffcbbeff),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff1d0061),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff4a00d4),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff23005c),
      secondaryFixedDim: Color(0xffd0bcff),
      onSecondaryFixedVariant: Color(0xff5500cb),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff230753),
      tertiaryFixedDim: Color(0xffd1bcff),
      onTertiaryFixedVariant: Color(0xff503a80),
      surfaceDim: Color(0xffddd7e7),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f1ff),
      surfaceContainer: Color(0xfff2ebfc),
      surfaceContainerHigh: Color(0xffece5f6),
      surfaceContainerHighest: Color(0xffe6e0f0),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff4600ca),
      surfaceTint: Color(0xff6326ff),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6c3cff),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5000c1),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff824afd),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4c357c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7f68b2),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffdf8ff),
      onBackground: Color(0xff1c1a25),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff1c1a25),
      surfaceVariant: Color(0xffe5e1e8),
      onSurfaceVariant: Color(0xff444248),
      outline: Color(0xff605e64),
      outlineVariant: Color(0xff7c7980),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f3b),
      inverseOnSurface: Color(0xfff4eefe),
      inversePrimary: Color(0xffcbbeff),
      primaryFixed: Color(0xff7a54ff),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff601eff),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff854eff),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff6b2ce6),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7f68b2),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff654f97),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd7e7),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f1ff),
      surfaceContainer: Color(0xfff2ebfc),
      surfaceContainerHigh: Color(0xffece5f6),
      surfaceContainerHighest: Color(0xffe6e0f0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff240073),
      surfaceTint: Color(0xff6326ff),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4600ca),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2a006d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5000c1),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2a1159),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4c357c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffdf8ff),
      onBackground: Color(0xff1c1a25),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffe5e1e8),
      onSurfaceVariant: Color(0xff242329),
      outline: Color(0xff444248),
      outlineVariant: Color(0xff444248),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f3b),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xfff0e9ff),
      primaryFixed: Color(0xff4600ca),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2f008f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5000c1),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff370088),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4c357c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff351e64),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd7e7),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f1ff),
      surfaceContainer: Color(0xfff2ebfc),
      surfaceContainerHigh: Color(0xffece5f6),
      surfaceContainerHighest: Color(0xffe6e0f0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbbeff),
      surfaceTint: Color(0xffcbbeff),
      onPrimary: Color(0xff330099),
      primaryContainer: Color(0xff5400ed),
      onPrimaryContainer: Color(0xfff4edff),
      secondary: Color(0xffd0bcff),
      onSecondary: Color(0xff3b0092),
      secondaryContainer: Color(0xff793ff4),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xffe7d9ff),
      onTertiary: Color(0xff392268),
      tertiaryContainer: Color(0xffc1a8f8),
      onTertiaryContainer: Color(0xff311a61),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff14121d),
      onBackground: Color(0xffe6e0f0),
      surface: Color(0xff14121d),
      onSurface: Color(0xffe6e0f0),
      surfaceVariant: Color(0xff48464c),
      onSurfaceVariant: Color(0xffc9c5cc),
      outline: Color(0xff938f96),
      outlineVariant: Color(0xff48464c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0f0),
      inverseOnSurface: Color(0xff312f3b),
      inversePrimary: Color(0xff6326ff),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff1d0061),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff4a00d4),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff23005c),
      secondaryFixedDim: Color(0xffd0bcff),
      onSecondaryFixedVariant: Color(0xff5500cb),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff230753),
      tertiaryFixedDim: Color(0xffd1bcff),
      onTertiaryFixedVariant: Color(0xff503a80),
      surfaceDim: Color(0xff14121d),
      surfaceBright: Color(0xff3a3744),
      surfaceContainerLowest: Color(0xff0f0d17),
      surfaceContainerLow: Color(0xff1c1a25),
      surfaceContainer: Color(0xff201e2a),
      surfaceContainerHigh: Color(0xff2b2834),
      surfaceContainerHighest: Color(0xff36333f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcfc3ff),
      surfaceTint: Color(0xffcbbeff),
      onPrimary: Color(0xff180053),
      primaryContainer: Color(0xff967cff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd3c1ff),
      onSecondary: Color(0xff1c004f),
      secondaryContainer: Color(0xff9f79ff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe7d9ff),
      onTertiary: Color(0xff2f175f),
      tertiaryContainer: Color(0xffc1a8f8),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff14121d),
      onBackground: Color(0xffe6e0f0),
      surface: Color(0xff14121d),
      onSurface: Color(0xfffef9ff),
      surfaceVariant: Color(0xff48464c),
      onSurfaceVariant: Color(0xffcdc9d0),
      outline: Color(0xffa5a1a8),
      outlineVariant: Color(0xff858288),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0f0),
      inverseOnSurface: Color(0xff2b2834),
      inversePrimary: Color(0xff4c00d7),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff120045),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff3900a8),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff160042),
      secondaryFixedDim: Color(0xffd0bcff),
      onSecondaryFixedVariant: Color(0xff4200a0),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff170040),
      tertiaryFixedDim: Color(0xffd1bcff),
      onTertiaryFixedVariant: Color(0xff3f286e),
      surfaceDim: Color(0xff14121d),
      surfaceBright: Color(0xff3a3744),
      surfaceContainerLowest: Color(0xff0f0d17),
      surfaceContainerLow: Color(0xff1c1a25),
      surfaceContainer: Color(0xff201e2a),
      surfaceContainerHigh: Color(0xff2b2834),
      surfaceContainerHighest: Color(0xff36333f),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffef9ff),
      surfaceTint: Color(0xffcbbeff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcfc3ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd3c1ff),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd5c1ff),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff14121d),
      onBackground: Color(0xffe6e0f0),
      surface: Color(0xff14121d),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff48464c),
      onSurfaceVariant: Color(0xfffef9ff),
      outline: Color(0xffcdc9d0),
      outlineVariant: Color(0xffcdc9d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e0f0),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff2c0087),
      primaryFixed: Color(0xffebe3ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcfc3ff),
      onPrimaryFixedVariant: Color(0xff180053),
      secondaryFixed: Color(0xffede2ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd3c1ff),
      onSecondaryFixedVariant: Color(0xff1c004f),
      tertiaryFixed: Color(0xffeee2ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd5c1ff),
      onTertiaryFixedVariant: Color(0xff1e004e),
      surfaceDim: Color(0xff14121d),
      surfaceBright: Color(0xff3a3744),
      surfaceContainerLowest: Color(0xff0f0d17),
      surfaceContainerLow: Color(0xff1c1a25),
      surfaceContainer: Color(0xff201e2a),
      surfaceContainerHigh: Color(0xff2b2834),
      surfaceContainerHighest: Color(0xff36333f),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
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

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
