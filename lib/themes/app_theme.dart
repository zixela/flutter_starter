import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme({this.context});

  ThemeData get lightTheme {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ThemeData.light().copyWith(
      // Colors
      primaryColor: Colors.white,
      primaryColorLight: AppColors.blueGreyLight,
      primaryColorDark: AppColors.black,
      accentColor: AppColors.deepOrange,
      dialogBackgroundColor: Color.fromRGBO(216, 216, 216, 0.6),
      secondaryHeaderColor: AppColors.deepOrangeLight,
      cardColor: Color.fromRGBO(254, 246, 239, 1),
      backgroundColor: AppColors.paleGreyLight,
      scaffoldBackgroundColor: AppColors.paleGreyLight,
      canvasColor: Colors.transparent,
      errorColor: AppColors.red,
      toggleableActiveColor: AppColors.green,
      indicatorColor: Color.fromRGBO(145, 159, 184, 1),
      dividerColor: Color.fromRGBO(234, 237, 242, 1),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: Color.fromRGBO(59, 59, 81, 1),
        selectedItemColor: Color.fromRGBO(242, 242, 246, 1),
      ),

      // Texts
      platform: TargetPlatform.iOS,
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.deepOrange,
        activeTickMarkColor: AppColors.deepOrange,
        thumbColor: Colors.white,
        overlayColor: AppColors.deepOrange.withOpacity(.2),
        inactiveTickMarkColor: AppColors.paleGreyLight,
        inactiveTrackColor: AppColors.paleGreyLight,
        valueIndicatorColor: AppColors.deepOrange,
      ),
      textTheme: textTheme.copyWith(
        headline1: textTheme.headline1.copyWith(),
        headline2: textTheme.headline2.copyWith(),
        headline3: textTheme.headline3.copyWith(),
        headline4: textTheme.headline4.copyWith(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'Helvetica_Caps',
          color: AppColors.black,
        ),
        headline5: textTheme.headline5.copyWith(
          fontSize: 24,
          fontFamily: 'Helvetica_Caps',
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headline6: textTheme.headline6.copyWith(
          color: AppColors.black,
          fontFamily: 'Helvetica',
          fontSize: 20,
        ),
        subtitle1: textTheme.subtitle1.copyWith(
          color: AppColors.blueGreyDark,
          fontFamily: 'Helvetica',
          fontSize: 16,
        ),
        subtitle2: textTheme.subtitle2.copyWith(
          color: AppColors.blueGreyDark,
          fontFamily: 'Helvetica',
          fontSize: 14,
        ),
        bodyText2: textTheme.bodyText2.copyWith(
          fontSize: 11,
          fontFamily: 'Helvetica',
          color: AppColors.blueGreyDark,
        ),
        bodyText1: textTheme.bodyText1.copyWith(
          fontSize: 16,
          fontFamily: 'Helvetica',
          color: AppColors.black,
        ),
        button: textTheme.button.copyWith(
          fontFamily: 'Helvetica_Caps',
          color: AppColors.black,
          fontSize: 14,
        ),
        caption: textTheme.caption.copyWith(
          color: AppColors.blueGrey,
          fontFamily: 'Helvetica',
          fontSize: 12,
        ),
        overline: textTheme.overline.copyWith(
          color: AppColors.blueGrey,
          fontFamily: 'Helvetica',
          letterSpacing: .15,
          fontSize: 10,
        ),
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.appBar,
      ),
    );
  }

  ThemeData get darkTheme {

  }
}
