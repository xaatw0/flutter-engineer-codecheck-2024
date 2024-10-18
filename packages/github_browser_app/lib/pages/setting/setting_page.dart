import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_browser_app/extensions/theme_mode_extensions.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/route/app_theme_color.dart';

import '../../route/app_state.dart';
import '../../widgets/atoms/app_text.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  static const path = '/setting';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMaterialYouAvailable =
        ref.read(appStateProvider).isMaterialYouAvailable;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // テーマモード
          AppText.caption(AppLocalizations.of(context).themeMode),
          SegmentedButton<ThemeMode>(
            onSelectionChanged: (themeMode) {
              ref
                  .read(appStateProvider.notifier)
                  .changeThemeMode(themeMode.first);
            },
            showSelectedIcon: false,
            segments: [
              for (final themeMode in ThemeMode.values)
                ButtonSegment(
                    value: themeMode,
                    label:
                        Text(themeMode.getTitle(AppLocalizations.of(context)))),
            ],
            selected: {ref.watch(appStateProvider).themeMode},
          ),
          const SizedBox(height: 16),

          // テーマカラー
          AppText.caption(AppLocalizations.of(context).themeColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (final appThemeColor in AppThemeColor.values.where(
                // MaterialYouは対応時のみ、その他の色は常に表示する
                (e) => e != AppThemeColor.materialYou || isMaterialYouAvailable,
              ))
                Builder(builder: (context) {
                  // テーマカラーの選択肢を表す丸とツールチップの色
                  final displayColor = appThemeColor.displayColor ??
                      getMaterialYouColor(context, ref);

                  // テーマカラーが変更になると再描画が必要なため、現在の色はwatch対象
                  final currentColor = ref
                      .watch(appStateProvider.select((e) => e.appThemeColor));

                  // 選択されているかでアイコンが変わる。MaterialYouはFaceになる
                  final iconData = currentColor == appThemeColor
                      ? Icons.circle
                      : appThemeColor == AppThemeColor.materialYou
                          ? Icons.face
                          : Icons.circle_outlined;

                  return Tooltip(
                    message:
                        appThemeColor.getTitle(AppLocalizations.of(context)),
                    decoration: BoxDecoration(
                      color: displayColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        ref
                            .read(appStateProvider.notifier)
                            .changeAppThemeColor(appThemeColor);
                      },
                      icon: Icon(iconData, size: 32, color: displayColor),
                    ),
                  );
                }),
            ],
          ),
        ],
      ),
    );
  }

  /// MaterialYouのプライマリーカラーを取得する
  Color? getMaterialYouColor(BuildContext context, WidgetRef ref) {
    return Theme.of(context).brightness == Brightness.light
        ? ref.read(appStateProvider).lightMaterialYouColor
        : ref.read(appStateProvider).dartMaterialYouColor;
  }
}
