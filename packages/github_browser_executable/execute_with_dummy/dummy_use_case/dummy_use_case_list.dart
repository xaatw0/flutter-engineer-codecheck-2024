import 'package:domain/use_case/keyword_suggestions_use_case.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:domain/use_case/use_case_list.dart';
import 'package:use_case/github_use_case/keyword_suggestions/search_repositories_keyword_suggestions_use_case.dart';

import 'dummy_search_repositories_use_case.dart';

class DummyUseCaseList implements UseCaseList {
  late final _searchRepositoriesUseCase = DummySearchRepositoriesUseCase();
  late final _keywordSuggestionsUseCase =
      SearchRepositoriesKeywordSuggestionsUseCase();
  @override
  SearchRepositoriesUseCase getSearchRepositoriesUseCase() {
    return _searchRepositoriesUseCase;
  }

  @override
  KeywordSuggestionsUseCase getKeywordSuggestionsUseCase() {
    return _keywordSuggestionsUseCase;
  }
}
