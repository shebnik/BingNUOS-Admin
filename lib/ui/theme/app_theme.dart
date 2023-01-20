import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bingnuos_admin_panel/constants.dart';

class AppTheme {
  static Color primary(BuildContext context) =>
      isLightTheme(context) ? primaryColor : Colors.white;
  static const primaryColor = Color(0xFF20354C);
  static const primaryColorDark = Color(0xffdfcab3);
  static const secondaryColor = Color.fromRGBO(62, 86, 148, 1);
  static const primaryBlue = Color(0xFF00ABDF);

  static ThemeData themeLight = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
    ),
    scaffoldBackgroundColor: const Color(0xFFFCFCFC),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: _appBarTitleStyle.copyWith(
        color: Colors.black,
      ),
    ),
    textTheme: _textTheme.copyWith(
      headline1: const TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontFamily: fontMontserrat,
      ),
      headline2: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: fontMontserrat,
      ),
      headline3: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: fontMontserrat,
      ),
      headline4: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: fontMontserrat,
      ),
      headline5: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: fontMontserrat,
      ),
      headline6: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: fontMontserrat,
      ),
      subtitle1: const TextStyle(
        color: Colors.black,
        fontFamily: fontMontserrat,
        fontSize: 16,
      ),
      subtitle2: const TextStyle(
        color: Colors.black,
        fontFamily: fontMontserrat,
        fontSize: 14,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: fontMontserrat,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: Colors.black,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static ThemeData themeDark = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    dividerColor: const Color(0xFFC6C6C9),
    sliderTheme: SliderThemeData(
      trackShape: CustomTrackShape(),
    ),
    scaffoldBackgroundColor: const Color(0xFF030303),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: _appBarTitleStyle.copyWith(
        color: Colors.white,
      ),
    ),
    textTheme: _textTheme.copyWith(
      headline1: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontFamily: fontMontserrat,
      ),
      headline2: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: fontMontserrat,
      ),
      headline3: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: fontMontserrat,
      ),
      headline4: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: fontMontserrat,
      ),
      headline5: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: fontMontserrat,
      ),
      headline6: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: fontMontserrat,
      ),
      subtitle1: const TextStyle(
        color: Colors.white,
        fontFamily: fontMontserrat,
        fontSize: 16,
      ),
      subtitle2: const TextStyle(
        color: Colors.white,
        fontFamily: fontMontserrat,
        fontSize: 14,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: fontMontserrat,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xFFCECFD0),
      ),
    ),
  );

  static const TextStyle _appBarTitleStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextTheme _textTheme = TextTheme(
    button: TextStyle(
      fontFamily: fontMontserrat,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    caption: TextStyle(
      fontFamily: fontMontserrat,
      color: Color(0xFFCECFD0),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );

  static bool isLightTheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light;
  }

  static Color getBrightnessColor(BuildContext context) {
    return isLightTheme(context) ? Colors.white : Colors.black;
  }

  static LinearGradient getAppGradient([double? opacity]) {
    return LinearGradient(
      colors: [
        const Color(0xFFFE616C).withOpacity(opacity ?? 1),
        const Color(0xFFFFC071).withOpacity(opacity ?? 1),
      ],
    );
  }

  static void setOverlayStyle([Color? color, BuildContext? context]) {
    final overlay = getSystemOverlayStyle(context);
    SystemChrome.setSystemUIOverlayStyle(
      color != null
          ? overlay.copyWith(systemNavigationBarColor: color)
          : overlay,
    );
  }

  static SystemUiOverlayStyle getSystemOverlayStyle(BuildContext? context) {
    return context != null
        ? isLightTheme(context)
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light;
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
