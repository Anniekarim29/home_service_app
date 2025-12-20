import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A comprehensive theme class for the Home Service App.
/// Provides defined colors, gradients, and text styles.
class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6610F2); // Electric Indigo
  static const Color secondaryColor = Color(0xFFA7FFEB); // Fresh Teal
  static const Color accentColor = Color(0xFFFFD180); // Soft Coral
  static const Color airyBlue = Color(0xFF80D8FF); // Airy Blue
  
  static const Color backgroundLight = Color(0xFFF8F9FA); // Soft Porcelain
  static const Color backgroundLavender = Color(0xFFF3E5F5); // Pale Lavender
  
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF757575);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6610F2), Color(0xFF80D8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient1 = LinearGradient(
    colors: [Color(0xFFA7FFEB), Color(0xFF80D8FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient2 = LinearGradient(
    colors: [Color(0xFFFFD180), Color(0xFFF3E5F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark Mode Colors
  static const Color backgroundDark = Color(0xFF000000); // Pure Black for maximum contrast
  static const Color surfaceDark = Color(0xFF1E1E1E); // Dark Grey for card surfaces
  static const Color neonPurple = Color(0xFFD500F9); // Vibrant Neon Purple for primary highlights
  static const Color neonBlue = Color(0xFF00B0FF); // Electric Blue for secondary highlights
  static const Color neonGreen = Color(0xFF00E676); // Neon Green for success indicators
  static const Color goldAccent = Color(0xFFFFD700); // Gold for premium badges and stats

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF000000), Color(0xFF1A1A1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [neonPurple, neonBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static TextStyle get displayMedium => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    color: textDark,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    color: textGrey,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    color: textGrey,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundLight,
      textTheme: TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundLight,
      ),
      useMaterial3: true,
    );
  }
}
