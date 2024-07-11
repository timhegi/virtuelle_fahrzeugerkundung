import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF313131),
    scaffoldBackgroundColor: const Color(0xFF313131),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF313131),
      foregroundColor: Colors.white70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          const Size(200.0, 50.0)),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(const Color(0xFF3D3D3D)),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF3D3D3D),
    ),
    cardColor: const Color(0xFF3D3D3D),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.black, fontSize: 18.0),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF3D3D3D),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    tabBarTheme: TabBarTheme(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.green,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      enableFeedback: false,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      showSelectedLabels: true,
    ),
  );
}
