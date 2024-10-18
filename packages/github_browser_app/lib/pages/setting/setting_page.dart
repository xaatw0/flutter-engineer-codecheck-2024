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
                Tooltip(
                  message: appThemeColor.getTitle(AppLocalizations.of(context)),
                  decoration: BoxDecoration(
                    color: appThemeColor.displayColor ??
                        getMaterialYouColor(context, ref),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ref
                          .read(appStateProvider.notifier)
                          .changeAppThemeColor(appThemeColor);
                    },
                    icon: Builder(builder: (context) {
                      final currentColor = ref.watch(
                          appStateProvider.select((e) => e.appThemeColor));
                      final iconData = currentColor == appThemeColor
                          ? Icons.circle
                          : appThemeColor == AppThemeColor.materialYou
                              ? Icons.face
                              : Icons.circle_outlined;

                      final color = appThemeColor.displayColor ??
                          getMaterialYouColor(context, ref);

                      return Icon(iconData, size: 32, color: color);
                    }),
                  ),
                ),
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
