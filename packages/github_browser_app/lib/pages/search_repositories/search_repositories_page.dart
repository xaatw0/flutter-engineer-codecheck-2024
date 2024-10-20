import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_browser_app/extensions/exceptions_when_loading_repositories_extensions.dart';
import 'package:github_browser_app/extensions/responsive_extension.dart';
import 'package:github_browser_app/pages/search_repositories/ask_before_reset.dart';
import 'package:github_browser_app/widgets/molecules/loading_indicator.dart';
import 'package:modeless_drawer/modeless_drawer.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

import '../../widgets/organisms/search_and_confirm_box.dart';
import 'search_repositories_state.dart';

part 'search_repositories_page.repository_tile.dart';
part 'search_repositories_page.detail_drawer.dart';

class SearchRepositoriesPage extends ConsumerWidget implements AskIfReset {
  const SearchRepositoriesPage({super.key});

  static const path = '/search_repositories';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch対象
    final isLoading =
        ref.watch(searchRepositoriesStateProvider.select((e) => e.isLoading));
    final isKeywordEmpty = ref.watch(
        searchRepositoriesStateProvider.select((e) => e.keyword.isEmpty));
    final items =
        ref.watch(searchRepositoriesStateProvider.select((e) => e.entities));

    final kerDrawer = GlobalKey<ModelessDrawerState<GitRepositoryEntity>>();

    // ウィンドウ幅が大きくなるにしたがって、タイルの数を増やす。
    // タイルを4列表示時でさらに広いようであれば、横に空白を作る
    final maxTileSize = WindowSize.medium.breakpoint * 4 / 5;
    final windowWidth = MediaQuery.sizeOf(context).width;
    final gridCrossAxisCount =
        context.responsive(1, medium: 2, large: 3, xLarge: 4);
    final gridPadding = maxTileSize * gridCrossAxisCount > windowWidth
        ? 0.0
        : (windowWidth - maxTileSize * gridCrossAxisCount) / 2;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SearchAndConfirmBox(
                  fetchSuggestions: (value) => ref
                      .read(searchRepositoriesStateProvider.notifier)
                      .getSuggestions(value),
                  onChangeKeyword: (value) => ref
                      .read(searchRepositoriesStateProvider.notifier)
                      .changeKeyword(value),
                  onSearch: () => onSearch(context,
                      ref.read(searchRepositoriesStateProvider.notifier)),
                  onReset: () => ref
                      .read(searchRepositoriesStateProvider.notifier)
                      .resetAfterAsk(this, context),
                  isKeywordEmpty: isKeywordEmpty,
                  isFuncSearched: () =>
                      ref.read(searchRepositoriesStateProvider).isSearched,
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: (ScrollEndNotification notification) {
                      final isScrollToEnd =
                          notification.metrics.extentAfter == 0;

                      if (isScrollToEnd) {
                        ref
                            .read(searchRepositoriesStateProvider.notifier)
                            .loadRepositories();
                      }
                      return false;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: gridPadding),
                      child: GridView.builder(
                          itemCount: items.length,
                          key: const PageStorageKey('SearchRepositoriesPage'),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: gridCrossAxisCount,
                            childAspectRatio: 4.5 / 1,
                          ),
                          itemBuilder: (context, index) {
                            return _RepositoryTile(
                              kerDrawer: kerDrawer,
                              item: items[index],
                            );
                          }),
                    ),
                  ),
                ),
                if (isLoading) const LoadingIndicator(),
              ],
            ),
            _DetailDrawer(kerDrawer: kerDrawer),
          ],
        ),
      ),
    );
  }

  void showSnackBarWhenCatchException(
    BuildContext context,
    Future<void> Function() funcLoading, {
    required void Function() onError,
  }) {
    funcLoading().catchError((ex) {
      if (context.mounted) {
        final errorMessage = ex is ExceptionsWhenLoadingRepositories
            ? ex.getMessage(AppLocalizations.of(context))
            : ex.toString();

        final snackBar = buildSnackBar(errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      onError();
    });
  }

  SnackBar buildSnackBar(String message) {
    return SnackBar(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      margin: const EdgeInsetsDirectional.all(8),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
            ),
            Text(message),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
      clipBehavior: Clip.hardEdge,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  void onSearch(BuildContext context, SearchRepositoriesState notifier) {
    showSnackBarWhenCatchException(
      context,
      () => notifier.loadRepositories(),
      onError: notifier.reset,
    );
  }

  @override
  Future<bool?> askIfReset(BuildContext context, String keyword) {
    return showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(AppLocalizations.of(context).resetConfirmation),
        content: Text(AppLocalizations.of(context)
            .repositoriesDeletedKeepKeyword(keyword)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).cancelAction),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).resetAction),
          ),
        ],
      ),
    );
  }
}
