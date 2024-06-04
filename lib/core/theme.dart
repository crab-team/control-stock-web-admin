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
  fillColor: Colors.transparent,
  contentPadding: EdgeInsets.zero,
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
  'headingRowColor': WidgetStateProperty.resolveWith((states) => colorScheme.primaryContainer),
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
  inversePrimary: const Color(0xFF0D0D0D),
  outline: const Color(0xFFE5E5E5),
  surface: const Color(0xFFFFFFFF),
  error: const Color(0xFFED1C15),
  errorContainer: const Color(0xFFFFD8E4),
  onError: const Color(0xFFFFFFFF),
);

extension ColorSchemeExtension on ColorScheme {
  Color get success => const Color(0xFF00A86B);
  Color get warning => const Color(0xFFE5A800);
  Color get disable => const Color(0xFFBDBDBD);
  Gradient get gradientPrimary => LinearGradient(
        colors: [primary, secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
}

extension ButtonStyleExtension on ButtonStyle {
  ButtonStyle primary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.primary);
  ButtonStyle secondary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.secondary);
  ButtonStyle tertiary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.tertiary);
  ButtonStyle inversePrimary() => ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary);
}

extension TextThemeExtension on Text {
  Text get displayLarge => Text(data!, style: theme.textTheme.displayLarge);
  Text get displayMedium => Text(data!, style: theme.textTheme.displayMedium);
  Text get displaySmall => Text(data!, style: theme.textTheme.displaySmall);
  Text get bodyLarge => Text(data!, style: theme.textTheme.bodyLarge);
  Text get bodyMedium => Text(data!, style: theme.textTheme.bodyMedium!);
  Text get bodySmall => Text(data!, style: theme.textTheme.bodySmall);
  Text get headlineLarge => Text(data!, style: theme.textTheme.headlineLarge);
  Text get headlineMedium => Text(data!, style: theme.textTheme.headlineMedium);
  Text get headlineSmall => Text(data!, style: theme.textTheme.headlineSmall);
  Text get labelLarge => Text(data!, style: theme.textTheme.labelLarge);
  Text get labelMedium => Text(data!, style: theme.textTheme.labelMedium);
  Text get labelSmall => Text(data!, style: theme.textTheme.labelSmall);
}

extension ElevatedButtonExtesion on ElevatedButton {
  ElevatedButton get primary => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary), child: child);
  ElevatedButton get secondary => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.secondary), child: child);
  ElevatedButton get tertiary => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.tertiary), child: child);
  ElevatedButton get inversePrimary => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary), child: child);
  ElevatedButton get cancel => ElevatedButton.icon(
        icon: const Icon(PhosphorIcons.x_circle),
        label: const Text(Texts.cancel),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: colorScheme.inversePrimary),
      );
  ElevatedButton get inverseCancel => ElevatedButton(
      onPressed: onPressed, style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary), child: child);

  ElevatedButton get save => ElevatedButton.icon(
        icon: const Icon(PhosphorIcons.floppy_disk),
        label: const Text(Texts.save, style: TextStyle(fontSize: 14)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: colorScheme.primary),
      );

  ElevatedButton get inverseSave => ElevatedButton(
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
    padding: WidgetStateProperty.all(
      kPaddingAppSmall.copyWith(top: 0, bottom: 0),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.primaryContainer, width: 1),
        borderRadius: BorderRadius.circular(kRadiusCornerInside),
      ),
    ),
    backgroundColor: WidgetStateProperty.all(Colors.white),
    surfaceTintColor: WidgetStateProperty.all(Colors.white),
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    shadowColor: WidgetStateProperty.all(Colors.transparent),
    hintStyle: WidgetStateProperty.all(
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
      backgroundColor: WidgetStateProperty.all(colorScheme.primary),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCornerInside),
        ),
      ),
      iconSize: WidgetStateProperty.all(14.0),
      textStyle: WidgetStateProperty.all(
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
      foregroundColor: WidgetStateProperty.all(colorScheme.inversePrimary),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusCornerInside),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: colorScheme.secondary,
    fillColor: colorScheme.surface,
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
