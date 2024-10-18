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

          // メインカラー
          AppText.caption(AppLocalizations.of(context).themeColor),
          Row(
            children: [
              for (final appThemeColor in AppThemeColor.values)
                IconButton(
                  onPressed: () {
                    ref
                        .read(appStateProvider.notifier)
                        .changeAppThemeColor(appThemeColor);
                  },
                  icon: Icon(
                    ref.watch(appStateProvider
                                .select((e) => e.appThemeColor)) ==
                            appThemeColor
                        ? Icons.circle
                        : Icons.circle_outlined,
                    size: 32,
                    color: appThemeColor.color,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
