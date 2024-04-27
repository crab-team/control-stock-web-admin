import 'package:control_stock_web_admin/presentation/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

const kPaddingApp = EdgeInsets.all(100.0);
const kPaddingAppSmall = EdgeInsets.all(16.0);
const kPaddingAppHorizontal = EdgeInsets.symmetric(horizontal: 52.0);
const kPaddingAppHorizontalSmall = EdgeInsets.symmetric(horizontal: 24.0);
const kPaddingAppHorizontalLarge = EdgeInsets.symmetric(horizontal: 100.0);
const kRadiusCornerOutside = 16.0;
const kRadiusCornerInside = 8.0;

const inputDataTableDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
  fillColor: Colors.transparent,
  border: InputBorder.none,
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  focusColor: Colors.transparent,
  hoverColor: Colors.transparent,
);

const dropdownAsFilterDecoration = InputDecoration(
  border: OutlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
  disabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
  contentPadding: EdgeInsets.zero,
  fillColor: Colors.transparent,
);

final dataTableDecoration = {
  'border': TableBorder(
    horizontalInside: BorderSide(color: colorScheme.primaryContainer),
    verticalInside: BorderSide(color: colorScheme.primaryContainer),
    bottom: BorderSide(color: colorScheme.primaryContainer),
    top: BorderSide(color: colorScheme.primaryContainer),
  ),
  'minWidth': 1200,
  'rowsPerPage': 20,
  'wrapInCard': false,
  'headingRowHeight': 42,
  'headingRowColor': MaterialStateProperty.resolveWith((states) => colorScheme.primaryContainer),
  'dataRowHeight': 42,
};

final ColorScheme colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Colors.white,
  primary: const Color(0xFF6F4BF2),
  primaryContainer: const Color.fromARGB(255, 244, 241, 254),
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

extension ButtonStyleExtension on ButtonStyle {
  ButtonStyle primary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.primary);
  ButtonStyle secondary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.secondary);
  ButtonStyle tertiary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.tertiary);
  ButtonStyle inversePrimary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary);
}

extension ElevatedButtonExtesion on ElevatedButton {
  ElevatedButton primary() => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary), child: child);
  ElevatedButton secondary() => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.secondary), child: child);
  ElevatedButton tertiary() => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.tertiary), child: child);
  ElevatedButton inversePrimary() => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary), child: child);
  ElevatedButton cancel() => ElevatedButton.icon(
        icon: const Icon(PhosphorIcons.x_circle),
        label: const Text(Texts.cancel),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary),
      );
  ElevatedButton inverseCancel() => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary), child: child);

  ElevatedButton save({bool isLarge = false}) => ElevatedButton.icon(
        icon: const Icon(PhosphorIcons.floppy_disk),
        label: Text(Texts.save, style: TextStyle(fontSize: isLarge ? 18 : 14)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
      );

  ElevatedButton inverseSave() => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary), child: child);
}

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
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(fontSize: 18),
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
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 4,
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
      backgroundColor: MaterialStateProperty.all(colorScheme.primary),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCornerInside),
        ),
      ),
      iconSize: MaterialStateProperty.all(14.0),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.white,
          fontSize: 14.0,
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
          borderRadius: BorderRadius.circular(kRadiusCornerInside),
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
    activeIndicatorBorder: BorderSide(color: colorScheme.primary),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerInside)),
      borderSide: BorderSide(color: colorScheme.primaryContainer),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerInside)),
      borderSide: BorderSide(color: colorScheme.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerInside)),
      borderSide: BorderSide(color: colorScheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerInside)),
      borderSide: BorderSide(color: colorScheme.error),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerInside)),
      borderSide: BorderSide(color: colorScheme.outline),
    ),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(kRadiusCornerInside)),
      borderSide: BorderSide(color: colorScheme.primaryContainer),
    ),
    contentPadding: kPaddingAppSmall,
    hintStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: colorScheme.inversePrimary.withOpacity(0.4),
    ),
    labelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: colorScheme.inversePrimary.withOpacity(0.4),
    ),
    helperStyle: TextStyle(
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
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: TextStyle(
      color: colorScheme.inversePrimary,
      fontSize: 16,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: colorScheme.primaryContainer,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
        borderSide: BorderSide(color: colorScheme.primaryContainer),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      contentPadding: kPaddingAppSmall,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: colorScheme.inversePrimary.withOpacity(0.4),
      ),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: colorScheme.inversePrimary.withOpacity(0.4),
      ),
      helperStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: colorScheme.inversePrimary.withOpacity(0.4),
      ),
    ),
  ),
);
