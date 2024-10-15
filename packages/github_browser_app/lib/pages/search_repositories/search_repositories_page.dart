import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modeless_drawer/modeless_drawer.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

import 'search_repositories_state.dart';

part 'search_repositories_page.repository_tile.dart';
part 'search_repositories_page.detail_drawer.dart';
part 'search_repositories_page.keyword_text_field.dart';
part 'search_repositories_page.search_cancel_button.dart';

class SearchRepositoriesPage extends ConsumerWidget {
  const SearchRepositoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch対象
    final isLoading =
        ref.watch(searchRepositoriesStateProvider.select((e) => e.isLoading));
    final isSearched =
        ref.watch(searchRepositoriesStateProvider.select((e) => e.isSearched));
    final isKeywordEmpty = ref.watch(
        searchRepositoriesStateProvider.select((e) => e.keyword.isEmpty));

    // 追加前後にisLoadingが変更、リセット時にisSearchedがfalseになるので、watchする必要がない
    final items = ref.read(searchRepositoriesStateProvider).entities;

    final _kerDrawer = GlobalKey<ModelessDrawerState<GitRepositoryEntity>>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _KeywordTextField(
                          isSearched: isSearched,
                          onChanged: ref
                              .read(searchRepositoriesStateProvider.notifier)
                              .changeKeyword,
                          onSubmitted: () => onSearch(
                              context,
                              ref.read(
                                  searchRepositoriesStateProvider.notifier)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        radius: 32,
                        child: _SearchCancelButton(
                          isSearched: isSearched,
                          isKeywordEmpty: isKeywordEmpty,
                          onReset: () => ref
                              .read(searchRepositoriesStateProvider.notifier)
                              .reset(),
                          onSearch: () => onSearch(
                              context,
                              ref.read(
                                  searchRepositoriesStateProvider.notifier)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: NotificationListener(
                  onNotification: (ScrollEndNotification notification) {
                    final isScrollToEnd = notification.metrics.extentAfter == 0;

                    if (isScrollToEnd) {
                      ref
                          .read(searchRepositoriesStateProvider.notifier)
                          .loadRepositories();
                    }
                    return false;
                  },
                  child: ListView.builder(
                      itemCount: items.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == items.length) {
                          return SizedBox.square(
                              dimension: 32.0,
                              child: const CircularProgressIndicator());
                        }

                        return _RepositoryTile(
                          kerDrawer: _kerDrawer,
                          item: items[index],
                        );
                      }),
                )),
              ],
            ),
            _DetailDrawer(kerDrawer: _kerDrawer),
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
      final errorMessage =
          ex is ExceptionsWhenLoadingRepositories ? ex.message : ex.toString();

      final snackBar = buildSnackBar(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      onError();
    });
  }

  SnackBar buildSnackBar(String message) {
    return SnackBar(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      margin: const EdgeInsetsDirectional.all(8),
      content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
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
}
