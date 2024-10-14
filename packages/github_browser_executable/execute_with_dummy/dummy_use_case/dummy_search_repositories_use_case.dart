import 'package:infrastructure/github_git_repository/data/github_search_repositories_data.dart';
import 'package:infrastructure/github_git_repository/github_git_repository.dart';
import 'package:use_case/github_use_case/github_search_repositories_use_case.dart';

part 'dummy_search_repositories_use_case.json.dart';

class DummySearchRepositoriesUseCase extends GithubSearchRepositoriesUseCase {
  DummySearchRepositoriesUseCase() : super(repository: _dummyRepository());
}

class _dummyRepository implements GithubGitRepository {
  final _dummyData = GithubSearchRepositoriesData.fromJson(_json);

  @override
  Future<GithubSearchRepositoriesData> searchRepositories(
      String keyword, int page) async {
    return _dummyData;
  }
}
