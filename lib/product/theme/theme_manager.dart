import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 10,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return const Color(0XFF6971DA).withOpacity(.48);
          }
          return const Color(0XFF6971DA);
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return const Color(0XFF6971DA).withOpacity(.48);
          }
          return const Color(0XFF6971DA).withOpacity(.48);
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      primaryColor: const Color(0xDB3987E7),
      colorScheme: const ColorScheme(
        primary: Color(0xDB3987E7),
        onPrimary: Colors.white,
        secondary: Color(0xDB3987E7),
        onSecondary: Color(0xDB3987E7),
        background: Colors.white,
        onBackground: Color(0XFFF4F5FC),
        error: Color(0XFFE55752),
        onError: Colors.white,
        surface: Colors.white54,
        onSurface: Colors.white,
        brightness: Brightness.light,
      ),
    );

extension BrightnessX on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}
