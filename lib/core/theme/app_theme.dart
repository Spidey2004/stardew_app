import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Cores inspiradas no Stardew Valley
  static const Color primaryBrown = Color(0xFF8B5A3C);
  static const Color lightBrown = Color(0xFFD4A574);
  static const Color darkBrown = Color(0xFF5C3A21);
  static const Color creamBackground = Color(0xFFFFF8DC);
  static const Color woodBorder = Color(0xFF6B4423);
  static const Color heartRed = Color(0xFFE74C3C);
  static const Color heartEmpty = Color(0xFFBDC3C7);
  static const Color giftGreen = Color(0xFF27AE60);
  
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryBrown,
        secondary: lightBrown,
        surface: creamBackground,
      ),
      scaffoldBackgroundColor: creamBackground,
      textTheme: GoogleFonts.pressStart2pTextTheme().apply(
        bodyColor: darkBrown,
        displayColor: darkBrown,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: woodBorder, width: 3),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBrown,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.pressStart2p(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}