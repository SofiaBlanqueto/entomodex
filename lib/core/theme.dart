import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const forest = Color(0xFF2F5D3A);
  static const amber = Color(0xFFE0A030);
  static const cream = Color(0xFFFAF5E9);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: forest,
      secondary: amber,
      surface: cream,
    );
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: cream,
      // Solución compatible con tu versión actual de google_fonts:
      textTheme: base.textTheme.apply(
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: forest,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
