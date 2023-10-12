import 'package:aqua_meal/constraints.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      canvasColor: kLightCanvasColor,
      brightness: Brightness.light,
      primarySwatch: colorCustom,
      primaryColor: kLightPrimaryColor,
      drawerTheme: const DrawerThemeData(backgroundColor: kLightPrimaryColor),
      cardColor: klightCardColor,
      buttonTheme: const ButtonThemeData(buttonColor: kLightPrimaryColor),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: textTheme(color: klightTextColor),
      scrollbarTheme: customScrollBarTheme(),
      dialogBackgroundColor: kLightCanvasColor,
      listTileTheme: listTileTheme(),
      dividerColor: whiteColor,
      tabBarTheme: tapBarTheme(),
      inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: kLightPrimaryColor, filled: true),
      appBarTheme: appBarTheme(backgroundColor: kLightPrimaryColor),
      snackBarTheme: snackBarTheme(
          backgroundColor: kLightPrimaryColor, textColor: kDarkTextColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: whiteColor,
        foregroundColor: kLightPrimaryColor,
        highlightElevation: 1000,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      canvasColor: kDarkConvasColor,
      brightness: Brightness.dark,
      primarySwatch: colorCustom,
      primaryColor: kDarkPrimaryColor,
      drawerTheme: const DrawerThemeData(backgroundColor: kDarkPrimaryColor),
      cardColor: kDarkCardColor,
      buttonTheme: const ButtonThemeData(buttonColor: kDarkPrimaryColor),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: textTheme(color: kDarkTextColor),
      scrollbarTheme: customScrollBarTheme(),
      dialogBackgroundColor: kDarkConvasColor,
      listTileTheme: listTileTheme(),
      dividerColor: whiteColor,
      tabBarTheme: tapBarTheme(),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: kLightPrimaryColor,
        filled: true,
      ),
      appBarTheme: appBarTheme(backgroundColor: kDarkPrimaryColor),
      snackBarTheme: snackBarTheme(
          backgroundColor: kLightCanvasColor, textColor: klightTextColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: whiteColor,
        foregroundColor: kDarkPrimaryColor,
        highlightElevation: 1000,
      ),
    );
  }
}

TabBarTheme tapBarTheme() {
  return const TabBarTheme(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: whiteColor),
    ),
  );
}

AppBarTheme appBarTheme({Color? backgroundColor}) {
  return AppBarTheme(
    actionsIconTheme: const IconThemeData(color: whiteColor),
    iconTheme: const IconThemeData(color: whiteColor),
    backgroundColor: backgroundColor,
    centerTitle: true,
    foregroundColor: whiteColor,
  );
}

TextTheme textTheme({Color? color}) {
  return TextTheme(
    bodyText1: TextStyle(color: color),
  );
}

ListTileThemeData listTileTheme() {
  return const ListTileThemeData(textColor: whiteColor, iconColor: whiteColor);
}

SnackBarThemeData snackBarTheme({Color? backgroundColor, Color? textColor}) {
  return SnackBarThemeData(
    backgroundColor: backgroundColor,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    actionTextColor: whiteColor,
    contentTextStyle: TextStyle(
      color: textColor!,
      fontWeight: FontWeight.w500,
    ),
  );
}

ExpansionTileThemeData expansionTileThemeData() {
  return const ExpansionTileThemeData(
    collapsedIconColor: kLightPrimaryColor,
    collapsedBackgroundColor: klightCardColor,
    backgroundColor: klightCardColor,
  );
}

ScrollbarThemeData customScrollBarTheme({
  Color? thumbColor,
  Color? trackColor,
}) {
  return ScrollbarThemeData(
    thickness: MaterialStateProperty.all<double?>(3),
    thumbColor: MaterialStateProperty.all<Color?>(whiteColor.withOpacity(0.7)),
    trackColor: MaterialStateProperty.all(whiteColor.withOpacity(0.4)),
    trackVisibility: MaterialStateProperty.all<bool?>(true),
    thumbVisibility: MaterialStateProperty.all<bool?>(true),
    interactive: true,
    radius: const Radius.circular(10),
    minThumbLength: 10,
  );
}
