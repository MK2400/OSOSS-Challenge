import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData mainTheme = ThemeData(
      primaryColor: AppColors.primaryColor,

      //appbar theme

      appBarTheme: AppBarTheme(
        color: AppColors.appBarColor,
      ),

      iconTheme: IconThemeData(color: AppColors.iconColor),
     );
}
