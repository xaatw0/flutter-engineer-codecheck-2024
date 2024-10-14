import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:infrastructure/github_git_repository/data/github_search_repositories_data.dart';
import 'package:infrastructure/github_git_repository/github_git_repository.dart';

class GithubSearchRepositoriesUseCase implements SearchRepositoriesUseCase {
  const GithubSearchRepositoriesUseCase(
      {this.repository = const GithubGitRepository()});

  final GithubGitRepository repository;

  @override
  Future<List<GitRepositoryEntity>> loadGitRepositories(
      String keyword, int page) async {
    final data = await repository.searchRepositories(keyword, page);
    return data.items.map((e) => _convert(e)).toList();
  }

  GitRepositoryEntity _convert(RepositoryItem item) {
    return GitRepositoryEntity(
      authorName: item.owner.login,
      repositoryName: item.name,
      description: item.description ?? '',
      authorImage: item.owner.avatarUrl,
      stargazersCount: item.stargazersCount,
      forksCount: item.forksCount,
      issuesCount: item.openIssuesCount,
      watchersCount: item.watchersCount,
      lastUpdatedAt: DateTime.parse(item.updatedAt),
    );
  }
}
