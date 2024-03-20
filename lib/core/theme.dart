import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPaddingApp = EdgeInsets.all(100.0);
const kPaddingAppSmall = EdgeInsets.all(24.0);
const kPaddingAppHorizontal = EdgeInsets.symmetric(horizontal: 52.0);
const kPaddingAppHorizontalLarge = EdgeInsets.symmetric(horizontal: 100.0);
const kRadiusCornerOutside = 16.0;
const kRadiusCornerInside = 8.0;

final ColorScheme colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.white,
  primary: const Color(0xFF6F4BF2),
  primaryContainer: const Color.fromARGB(255, 240, 236, 255),
  secondary: const Color(0xFF0FA4E4),
  secondaryContainer: const Color.fromARGB(255, 221, 245, 255),
  tertiary: const Color(0xFFED5B15),
  tertiaryContainer: const Color(0xFFFFD8E4),
  error: const Color(0xFF02191f),
  errorContainer: const Color(0xFFE5E5E5),
  inversePrimary: const Color(0xFF0D0D0D),
  outline: const Color(0xFFE5E5E5),
  background: const Color(0xFFFFFFFF),
  onError: const Color(0xFFED1C15),
);

final ThemeData theme = ThemeData(
  fontFamily: 'Lato',
  useMaterial3: true,
  colorScheme: colorScheme,
  appBarTheme:
      const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, surfaceTintColor: Colors.transparent),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      letterSpacing: 0.0,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    padding: MaterialStateProperty.all(
      kPaddingAppSmall.copyWith(top: 0, bottom: 0),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.primaryContainer, width: 1),
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    surfaceTintColor: MaterialStateProperty.all(Colors.white),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    hintStyle: MaterialStateProperty.all(
      TextStyle(
        color: colorScheme.inversePrimary.withOpacity(0.4),
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 4,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: colorScheme.primaryContainer, width: 1),
      borderRadius: const BorderRadius.all(
        Radius.circular(kRadiusCornerInside),
      ),
    ),
  ),
  dividerTheme: DividerThemeData(
    space: 0,
    thickness: 1,
    color: colorScheme.primaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(colorScheme.inversePrimary),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(kPaddingAppSmall),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCornerInside),
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
          borderRadius: BorderRadius.circular(kRadiusCornerOutside),
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
    fillColor: colorScheme.background,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerOutside)),
      borderSide: BorderSide(color: colorScheme.primaryContainer),
    ),
    contentPadding: kPaddingAppSmall,
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: colorScheme.inversePrimary.withOpacity(0.4),
    ),
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: colorScheme.primaryContainer,
    dialBackgroundColor: colorScheme.primaryContainer,
  ),
  disabledColor: colorScheme.outline,
  cupertinoOverrideTheme: CupertinoThemeData(
    barBackgroundColor: colorScheme.secondaryContainer,
    primaryColor: colorScheme.primaryContainer,
    scaffoldBackgroundColor: colorScheme.primaryContainer,
    primaryContrastingColor: colorScheme.primaryContainer,
    applyThemeToAll: true,
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      primaryColor: colorScheme.primary,
      dateTimePickerTextStyle: TextStyle(color: colorScheme.onError),
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
      borderRadius: BorderRadius.circular(kRadiusCornerOutside),
    ),
    actionsPadding: const EdgeInsets.all(12),
  ),
);
