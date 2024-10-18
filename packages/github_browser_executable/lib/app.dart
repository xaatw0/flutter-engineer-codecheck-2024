import 'package:domain/service_locator.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/route/app_state.dart';
import 'package:github_browser_app/route/app_theme_color.dart';
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
        return DynamicColorBuilder(
            builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          // Material You 対応時は非null、 非対応時はnullになる
          // 対応していれば、ベースカラーを保存する
          final isMaterialYouAvailable = lightDynamic != null;
          if (isMaterialYouAvailable) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref
                  .read(appStateProvider.notifier)
                  .changeMaterialYouAvailable(isMaterialYouAvailable);

              ref.read(appStateProvider.notifier).changeMaterialYouColor(
                  lightDynamic.primary, darkDynamic?.primary);
            });
          }

          // 設定画面でテーマカラーが変更された場合、全ての画面で変更があるので、watch対象になる
          final selectedThemeColor =
              ref.watch(appStateProvider.select((e) => e.appThemeColor));

          /// MaterialYouが選択されており、かつ、有効な場合は、MaterialYou用のカラースキームを使用する
          ///
          /// [colorSchemeForMaterialYou] MaterialYouのカラースキーム
          ColorScheme getColorScheme(
            ColorScheme? colorSchemeForMaterialYou,
            Brightness brightness,
          ) {
            return selectedThemeColor == AppThemeColor.materialYou &&
                    colorSchemeForMaterialYou != null
                ? colorSchemeForMaterialYou
                : ColorScheme.fromSeed(
                    seedColor: selectedThemeColor.color,
                    brightness: brightness);
          }

          return MaterialApp.router(
            title: F.title,
            routerConfig: router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: ref.watch(appStateProvider.select((e) => e.themeMode)),
            theme: ThemeData(
              colorScheme: getColorScheme(lightDynamic, Brightness.light),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: getColorScheme(darkDynamic, Brightness.dark),
            ),
            builder: (context, child) => _flavorBanner(
              show: kDebugMode,
              child: child ?? Container(),
            ),
          );
        });
      }),
    ),
  );
}
