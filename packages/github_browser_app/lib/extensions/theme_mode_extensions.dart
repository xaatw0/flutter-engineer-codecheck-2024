import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

/// テーマモードのタイトル
extension ThemeModeExtensions on ThemeMode {
  String getTitle(AppLocalizations appLoc) => switch (this) {
        ThemeMode.system => appLoc.system,
        ThemeMode.light => appLoc.light,
        ThemeMode.dark => appLoc.dark,
      };
}
