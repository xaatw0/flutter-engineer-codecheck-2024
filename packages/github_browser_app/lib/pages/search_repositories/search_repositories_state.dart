import 'package:domain/service_locator.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:github_browser_app/pages/search_repositories/ask_before_reset.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'search_repositories_model.dart';
part 'search_repositories_state.g.dart';

@Riverpod(keepAlive: true)
class SearchRepositoriesState extends _$SearchRepositoriesState {
  SearchRepositoriesUseCase get _useCase =>
      ServiceLocator.singleton().useCaseList.getSearchRepositoriesUseCase();

  @override
  SearchRepositoriesModel build() => const SearchRepositoriesModel(
        keyword: '',
        isSearched: false,
        page: 1,
        isLoading: false,
        entities: [],
      );

  void changeKeyword(String keyword) =>
      state = state.copyWith(keyword: keyword);

  void reset() {
    final keyword = state.keyword;
    state = build().copyWith(keyword: keyword);
  }

  Future<void> loadRepositories() async {
    state = state.copyWith(
      isSearched: true,
      isLoading: true,
    );

    final repositories =
        await _useCase.loadGitRepositories(state.keyword, state.page);

    state = state.copyWith(
      page: state.page + 1,
      isLoading: false,
      entities: [...state.entities, ...repositories],
    );
  }

  Future<void> resetAfterAsk(
      AskIfReset humbleObject, BuildContext context) async {
    // レポジトリ読み込み中は、キャンセルできないとする
    if (state.isLoading) {
      return;
    }

    final result = await humbleObject.askIfReset(
      context,
      state.keyword,
    );

    if (result == true) {
      reset();
    }
  }
}
