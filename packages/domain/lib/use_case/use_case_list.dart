import 'package:domain/use_case/keyword_suggestions_use_case.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';

abstract class UseCaseList {
  SearchRepositoriesUseCase getSearchRepositoriesUseCase();
  KeywordSuggestionsUseCase getKeywordSuggestionsUseCase();
}
