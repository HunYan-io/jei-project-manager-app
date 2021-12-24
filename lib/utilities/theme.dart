import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final theme = ThemeData();
    const primaryColor = Color(0xFF171a33);
    const secondaryColor = Color(0xFF8a2831);
    return ThemeData(
      colorScheme: theme.colorScheme.copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      fontFamily: 'Quicksand',
      textTheme: theme.textTheme.apply(displayColor: primaryColor),
    );
  }
}
