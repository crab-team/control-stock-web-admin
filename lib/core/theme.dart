import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPaddingApp = EdgeInsets.all(24.0);
const kPaddingAppSmall = EdgeInsets.all(12.0);
const kPaddingAppHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
const kRadiusCorner = 28.0;

final ColorScheme colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.white,
  primary: const Color(0xFF567DF4),
  primaryContainer: const Color(0xFFF3F6FF),
  secondary: const Color(0xFF677191),
  secondaryContainer: const Color(0xFFE2E9FD),
  tertiary: const Color(0xFFF5B556),
  tertiaryContainer: const Color(0xFFFFD8E4),
  error: const Color(0xFF02191f),
  errorContainer: const Color(0xFFE5E5E5),
  inversePrimary: const Color(0xFF2C2D30),
  outline: const Color(0xFFE5E5E5),
  background: const Color(0xFFFFFFFF),
  onError: const Color(0xFFD8000C),
);

final ThemeData theme = ThemeData(
  fontFamily: 'Lato',
  useMaterial3: true,
  colorScheme: colorScheme,
  appBarTheme:
      const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, surfaceTintColor: Colors.transparent),
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    displayMedium: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    displaySmall: const TextStyle(
      letterSpacing: 0.0,
    ),
    bodyLarge: const TextStyle(
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: const TextStyle(
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: colorScheme.secondary,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: colorScheme.secondary,
    ),
    labelLarge: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelMedium: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: colorScheme.primary,
    ),
  ),
  cardTheme: CardTheme(
    color: colorScheme.primaryContainer,
    surfaceTintColor: colorScheme.primaryContainer,
    elevation: 4,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kRadiusCorner))),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(colorScheme.inversePrimary),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(kPaddingApp),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCorner),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(colorScheme.inversePrimary),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCorner),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: colorScheme.secondary,
    fillColor: colorScheme.primaryContainer,
    filled: true,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kRadiusCorner)),
      borderSide: BorderSide.none,
    ),
    contentPadding: kPaddingAppSmall,
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: colorScheme.secondary,
    ),
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: colorScheme.primaryContainer,
    dialBackgroundColor: colorScheme.primaryContainer,
  ),
  disabledColor: Colors.grey,
  cupertinoOverrideTheme: CupertinoThemeData(
    barBackgroundColor: colorScheme.secondaryContainer,
    primaryColor: colorScheme.primaryContainer,
    scaffoldBackgroundColor: colorScheme.primaryContainer,
    primaryContrastingColor: colorScheme.primaryContainer,
    applyThemeToAll: true,
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      primaryColor: colorScheme.primary,
      dateTimePickerTextStyle: const TextStyle(color: Colors.red),
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.transparent, elevation: 0),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    selectedItemColor: colorScheme.primary,
    unselectedItemColor: colorScheme.secondary,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusCorner),
    ),
    actionsPadding: const EdgeInsets.all(12),
  ),
);
