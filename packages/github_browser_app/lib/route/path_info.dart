import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

class PathInfo {
  const PathInfo(
    this.path,
    this.widget,
    this.iconData,
    this.getTitle,
  );

  final String path;
  final Widget widget;
  final IconData iconData;
  final String Function(AppLocalizations appLoc) getTitle;
}
