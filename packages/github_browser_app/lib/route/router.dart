import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/pages/search_repositories/search_repositories_page.dart';
import 'package:github_browser_app/pages/setting/setting_page.dart';
import 'path_info.dart';
import 'package:github_browser_app/widgets/templates/non_authenticated_template.dart';
import 'package:go_router/go_router.dart';

final pathInfoList = [
  // 検索画面
  PathInfo(
    SearchRepositoriesPage.path,
    SearchRepositoriesPage(),
    Icons.search,
    (appLoc) => appLoc.repositorySearch,
  ),
  // 設定画面
  PathInfo(
    SettingPage.path,
    SettingPage(),
    Icons.settings,
    (appLoc) => appLoc.settings,
  )
];

final router = GoRouter(
  initialLocation: pathInfoList.first.path,
  routes: [
    for (final pathInfo in pathInfoList)
      GoRoute(
        path: pathInfo.path,
        pageBuilder: (BuildContext context, GoRouterState? state) =>
            MaterialPage(
          child: NonAuthenticatedTemplate(
              title: pathInfo.getTitle(AppLocalizations.of(context)),
              child: pathInfo.widget),
        ),
      ),
  ],
);
