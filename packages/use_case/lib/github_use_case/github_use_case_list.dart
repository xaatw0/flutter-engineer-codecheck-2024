import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:domain/use_case/use_case_list.dart';
import 'package:use_case/github_use_case/github_search_repositories_use_case.dart';

class GithubUseCaseList implements UseCaseList {
  late final _searchRepositoriesUseCase = GithubSearchRepositoriesUseCase();

  @override
  SearchRepositoriesUseCase getSearchRepositoriesUseCase() {
    return _searchRepositoriesUseCase;
  }
}
