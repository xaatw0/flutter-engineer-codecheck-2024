import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

enum AppThemeColor {
  red(Colors.red),
  green(Colors.green),
  blue(Colors.blue),
  yellow(Colors.yellow),
  magenta(Colors.purple),
  cyan(Colors.cyan);

  const AppThemeColor(this.color);
  final Color color;
}

extension AppThemeColorExtension on AppThemeColor {
  String getTitle(AppLocalizations appLoc) => switch (this) {
        AppThemeColor.red => appLoc.red,
        AppThemeColor.green => appLoc.green,
        AppThemeColor.blue => appLoc.blue,
        AppThemeColor.yellow => appLoc.yellow,
        AppThemeColor.magenta => appLoc.magenta,
        AppThemeColor.cyan => appLoc.cyan,
      };
}
