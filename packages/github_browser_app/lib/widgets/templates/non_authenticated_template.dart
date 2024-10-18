import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/route/app_state.dart';
import 'package:github_browser_app/route/router.dart';
import 'package:go_router/go_router.dart';

/// 画面のフレームワーク<br/>
/// タイトルとボトムナビゲーションバーを共通で設定
class NonAuthenticatedTemplate extends ConsumerWidget {
  const NonAuthenticatedTemplate({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: ref.watch(
            appStateProvider.select((e) => e.selectedNavigatorIndex),
          ),
          onDestinationSelected: (index) {
            ref.read(appStateProvider.notifier).changeNavigatorIndex(index);
            GoRouter.of(context).go(pathInfoList[index].path);
          },
          animationDuration: const Duration(milliseconds: 300),
          destinations: [
            for (final pathInfo in pathInfoList)
              NavigationDestination(
                icon: Icon(pathInfo.iconData),
                label: pathInfo.getTitle(AppLocalizations.of(context)),
              ),
          ],
        ),
        body: SafeArea(child: child));
  }
}
