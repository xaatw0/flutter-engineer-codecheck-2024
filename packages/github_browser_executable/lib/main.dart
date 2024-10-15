import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:github_browser_app/pages/search_repositories/search_repositories_page.dart';
import 'package:domain/service_locator.dart';
import 'package:use_case/github_use_case/github_use_case_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:github_browser_app/gen_l10n/app_localizations.dart';

void main() {
  ServiceLocator.init(http.Client(), GithubUseCaseList());

  run();
}

void run() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SearchRepositoriesPage(),
      ),
    ),
  );
}
