import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light(Color seed) => ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      floatingLabelStyle: TextStyle(
        color: Color.fromARGB(255, 1, 87, 79),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: Color.fromARGB(255, 1, 113, 102),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.teal,
      selectionColor: Colors.teal,
      selectionHandleColor: Colors.teal,
    ),
  );

  static ThemeData dark(Color seed) => ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      floatingLabelStyle: TextStyle(
        color: Color.fromARGB(255, 1, 87, 79),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: Color.fromARGB(255, 1, 113, 102),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.teal,
      selectionColor: Colors.teal,
      selectionHandleColor: Colors.teal,
    ),
  );
}
