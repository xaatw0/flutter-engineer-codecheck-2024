import 'package:domain/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/route/app_state.dart';
import 'package:github_browser_app/route/router.dart';
import 'package:http/http.dart' as http;
import 'package:use_case/github_use_case/github_use_case_list.dart';

import 'flavors.dart';

Future<void> main() async {
  ServiceLocator.init(http.Client(), GithubUseCaseList());

  run();
}

Widget _flavorBanner({
  required Widget child,
  bool show = true,
}) =>
    show
        ? Banner(
            child: child,
            location: BannerLocation.topStart,
            message: F.name,
            color: Colors.green.withOpacity(0.6),
            textStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
          )
        : Container(
            child: child,
          );

void run() {
  runApp(
    ProviderScope(
      child: Consumer(builder: (context, ref, _) {
        return MaterialApp.router(
          title: F.title,
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: ref.watch(appStateProvider.select((e) => e.themeMode)),
          theme: ThemeData(),
          darkTheme: ThemeData(brightness: Brightness.dark),
          builder: (context, child) => _flavorBanner(
            show: kDebugMode,
            child: child ?? Container(),
          ),
        );
      }),
    ),
  );
}
