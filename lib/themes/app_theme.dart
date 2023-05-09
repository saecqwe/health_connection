import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    // primarySwatch: Colors.black,

    brightness: Brightness.light,
    highlightColor: Colors.transparent,
    appBarTheme: appBarTheme(),
    tabBarTheme: tabTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: inputTheme(),
    textTheme: textTheme(),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}

InputDecorationTheme inputTheme() {
  return InputDecorationTheme(
    focusColor: Colors.black,
    fillColor: Colors.grey.shade50,
    filled: true,
    isDense: true,
    labelStyle: const TextStyle(color: Colors.black54),
    floatingLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ),
    ),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    elevation: .50,
    color: AppColors.appColor,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}

TabBarTheme tabTheme() {
  return const TabBarTheme(
    labelColor: Colors.black,

    labelStyle: TextStyle(fontWeight: FontWeight.bold), // color for text
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.appColor),
    ),
  );
}

TextStyle inputText = const TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
);

TextTheme textTheme() {
  return const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}
