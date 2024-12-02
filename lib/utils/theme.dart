import 'package:flutter/material.dart';

class AppTheme {
  static TextDirection textDirection = TextDirection.ltr;

  static const String fontFamily = 'AfacadFlux';

  static ThemeData appTheme = lightTheme.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff00509d),
      brightness: Brightness.light,
      primary: const Color(0xff00509d),
      onSurface: Colors.black87,
      surface: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff00509d),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        side: const BorderSide(color: Color(0xff00509d), width: 1.4),
        // foregroundColor: Colors.white,
        // backgroundColor: const Color(0xff006399),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
      ),
    ),
  );

  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    /// Brightness
    brightness: Brightness.light,

    /// Primary Color
    primaryColor: const Color(0xff3C4EC5),
    scaffoldBackgroundColor: const Color(0xffffffff),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xffffffff),
      iconTheme: IconThemeData(color: Color(0xff495057)),
      actionsIconTheme: IconThemeData(color: Color(0xff495057)),
    ),

    // Drawer Theme
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xffffffff)),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xfff0f0f0)),
    cardColor: const Color(0xfff0f0f0),

    fontFamily: fontFamily,
    textTheme: _getTextTheme(),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff3C4EC5),
        splashColor: const Color(0xffeeeeee).withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xff3C4EC5),
        hoverColor: const Color(0xff3C4EC5),
        foregroundColor: const Color(0xffeeeeee)),

    // InputDecorationTheme
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 19,
        letterSpacing: 0.15,
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 19,
        letterSpacing: 0.15,
      ),
      errorStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      suffixIconColor: Color(0xff3C4EC5),
    ),

    /// Divider Theme
    dividerTheme:
        const DividerThemeData(color: Color(0xffe8e8e8), thickness: 1),
    dividerColor: const Color(0xffe8e8e8),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xffeeeeee), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff3d63ff),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff3d63ff), width: 2.0),
      ),
    ),

    /// Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(const Color(0xff3C4EC5)),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0x990A6FB8);
        }
        return null;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state) {
        const Set<WidgetState> interactiveStates = <WidgetState>{
          WidgetState.pressed,
          WidgetState.hovered,
          WidgetState.focused,
          WidgetState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xff3C4EC5);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xff3d63ff),
      inactiveTrackColor: const Color(0xff3d63ff).withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xff3d63ff),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xffeeeeee),
      ),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    indicatorColor: const Color(0xffeeeeee),
    highlightColor: const Color(0xffeeeeee),
    colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff3C4EC5), brightness: Brightness.light)
        .copyWith(surface: const Color(0xffffffff))
        .copyWith(error: const Color(0xfff0323c)),
  );

  static TextTheme _getTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(fontFamily: fontFamily, fontSize: 99),
      displayMedium: TextStyle(fontFamily: fontFamily, fontSize: 62),
      displaySmall: TextStyle(fontFamily: fontFamily, fontSize: 50),
      headlineMedium: TextStyle(fontFamily: fontFamily, fontSize: 42.5),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 26,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 17.5,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: .4,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 17,
        height: 1.15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
  }
}
