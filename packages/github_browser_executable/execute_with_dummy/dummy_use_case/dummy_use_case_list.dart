import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:domain/use_case/use_case_list.dart';

import 'dummy_search_repositories_use_case.dart';

class DummyUseCaseList implements UseCaseList {
  late final _searchRepositoriesUseCase = DummySearchRepositoriesUseCase();

  @override
  SearchRepositoriesUseCase getSearchRepositoriesUseCase() {
    return _searchRepositoriesUseCase;
  }
}
