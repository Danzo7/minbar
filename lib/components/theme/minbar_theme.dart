import 'package:flutter/material.dart';
import 'package:minbar_fl/components/theme/default_theme.dart';

const kLongAnimationDuration = Duration(milliseconds: 400);
const kShortAnimationDuration = Duration(milliseconds: 120);
const kFastAnimationDuration = Duration(milliseconds: 90);
const kFlashAnimationDuration = Duration(milliseconds: 10);
const kMedAnimationDuration = Duration(milliseconds: 200);

class MinbarTheme with MinbarColorScheme {
  ThemeData light() => ThemeData(
      primaryColorDark: DColors.white,
      primaryColorLight: DColors.blueGray,
      primaryColor: DColors.grayBrown,
      fontFamily: 'Cairo',
      colorScheme: _light(),
      textTheme: const TextTheme(
          headline1: TextStyle(fontWeight: FontWeight.w200),
          headline6: TextStyle(fontWeight: FontWeight.w200),
          bodyText2: TextStyle(fontWeight: FontWeight.w200),
          button: TextStyle(fontWeight: FontWeight.w200)),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
        return DColors.white;
      }), trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return DColors.green;
        }
        return DColors.grayBrown;
      })),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => DColors.sailBlue),
      ));

  ThemeData dark() => ThemeData(
      primaryColorDark: DColors.white,
      primaryColorLight: DColors.blueGray,
      primaryColor: DColors.grayBrown,
      fontFamily: 'Cairo',
      colorScheme: _dark(),
      textTheme: const TextTheme(
          headline1: TextStyle(fontWeight: FontWeight.w200),
          headline6: TextStyle(fontWeight: FontWeight.w200),
          bodyText2: TextStyle(fontWeight: FontWeight.w200),
          button: TextStyle(fontWeight: FontWeight.w200)),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
        return DColors.white;
      }), trackColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.selected)) {
          return DColors.green;
        }
        return DColors.grayBrown;
      })),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => DColors.sailBlue),
      ));
}

mixin MinbarColorScheme {
  late Color primary;
  late Color primaryVariant;
  late Color secondary;
  late Color secondaryVariant;
  late Color surface;
  late Color background;
  late Color onPrimary;
  late Color onSecondary;
  late Color onSurface;
  late Color onBackground;
  late Brightness brightness;
  late Color actionCold = DColors.green;
  late Color actionWarm = DColors.orange;
  late Color actionHot = DColors.sadRed;
  late Color onAction = DColors.white;
  late Color surfaceBorder;

  ColorScheme _light() {
    primary = DColors.sailBlue;
    primaryVariant = DColors.sailBlueDark;
    secondary = DColors.blueGray;
    secondaryVariant = DColors.blueSaidGray;
    surface = DColors.white;
    background = DColors.white;
    onPrimary = Colors.white;
    onSecondary = Colors.white;
    onSurface = DColors.grayBrown;
    onBackground = DColors.blueGray;
    brightness = Brightness.light;
    surfaceBorder = DColors.coldGray;
    return ColorScheme(
        primary: primary,
        secondary: secondary,
        primaryVariant: primaryVariant,
        secondaryVariant: secondaryVariant,
        surface: surface,
        background: background,
        brightness: brightness,
        onBackground: onBackground,
        error: actionHot,
        onError: onAction,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface);
  }

  ColorScheme _dark() {
    primary = DColors.blueGray;
    primaryVariant = DColors.blueSaidGray;
    secondary = DColors.sailBlue;
    secondaryVariant = DColors.sailBlueDark;
    surface = DColors.white;
    background = DColors.white;
    onPrimary = Colors.white;
    onSecondary = Colors.white;
    onSurface = DColors.grayBrown;
    onBackground = DColors.blueGray;
    brightness = Brightness.light;
    surfaceBorder = DColors.coldGray;
    return ColorScheme(
        primary: primary,
        secondary: secondary,
        primaryVariant: primaryVariant,
        secondaryVariant: secondaryVariant,
        surface: surface,
        background: background,
        brightness: brightness,
        onBackground: onBackground,
        error: actionHot,
        onError: onAction,
        onPrimary: onPrimary,
        onSecondary: onSecondary,
        onSurface: onSurface);
  }
}
