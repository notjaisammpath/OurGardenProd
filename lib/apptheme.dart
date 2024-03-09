import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          },
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.getFont(
          'Open Sans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.BLACK
        ),
        actionsIconTheme: const IconThemeData(
            color: AppColor.PRIMARY),
        iconTheme: const IconThemeData(
            color :AppColor.PRIMARY),
        backgroundColor: AppColor.WHITE,
      ),
      cardTheme:  const CardTheme(
        color: AppColor.WHITE
      ),
      primaryColor: AppColor.PRIMARY,
      highlightColor: AppColor.PRIMARY,
      scaffoldBackgroundColor: AppColor.BG_COLOR,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.BLACK
        ),
        displayMedium: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.BLACK
        ),
        displaySmall: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColor.BLACK
        ),
        titleLarge: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.BLACK
        ),
        titleMedium: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.BLACK
        ),
        titleSmall: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColor.BLACK
        ),
        bodyLarge:GoogleFonts.getFont(
            'Open Sans',
            fontSize: 16,
            color: AppColor.BLACK
        ),
        bodyMedium: GoogleFonts.getFont(
            'Open Sans',
            fontSize: 14,
            color: AppColor.BLACK
        ),        bodySmall: GoogleFonts.getFont(
          'Open Sans',
          fontSize: 12,
          color: AppColor.BLACK.withOpacity(0.4)
        ),
      ),
      iconTheme: const IconThemeData(color: AppColor.PRIMARY),
      textButtonTheme: TextButtonThemeData(
        style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
          foregroundColor: MaterialStateProperty.all<Color>(AppColor.WHITE),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
            )
          )
        )
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
        selectedColor: AppColor.BODY_COLOR,
        fillColor: AppColor.BODY_COLOR.withOpacity(0.1),
        textStyle: const TextStyle(color: AppColor.WHITE),
        selectedBorderColor: AppColor.BODY_COLOR,
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme:  ColorScheme.fromSwatch().copyWith(
        primary: AppColor.PRIMARY,
        onPrimary: AppColor.PRIMARY,
        secondary: AppColor.SECONDARY,
        onSecondary: AppColor.SECONDARY,
        surface: AppColor.BG_COLOR,
        onSurface: AppColor.BG_COLOR,
        error: Colors.red,
        onError: Colors.red,
        background: AppColor.BG_COLOR,
        onBackground: AppColor.BG_COLOR,
        brightness: Brightness.light,
      ),
    );
  }
}
class AppColor{

static const PRIMARY = Color(0xff5e8b63);
static const BG_COLOR = Color(0xff96af95);
static const SECONDARY = Color(0xffd9c2b2);
static const TEXT_COLOR = Color(0xffd9c2b2);
static const TEXT_SECONDARY_COLOR = Color(0xff999999);
static const BODY_COLOR = Color(0xff2e2e2e); 
static const WHITE = Colors.white;
static const BLACK = Colors.black;

}