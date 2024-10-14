import 'package:domain/service_locator.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'search_repositories_model.dart';
part 'search_repositories_state.g.dart';

@Riverpod(keepAlive: true)
class SearchRepositoriesState extends _$SearchRepositoriesState {
  SearchRepositoriesUseCase get _useCase =>
      ServiceLocator.singleton().useCaseList.getSearchRepositoriesUseCase();

  @override
  SearchRepositoriesModel build() => SearchRepositoriesModel(
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
}
