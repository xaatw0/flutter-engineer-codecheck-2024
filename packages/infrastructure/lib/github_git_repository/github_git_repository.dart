import 'dart:convert';

import 'package:domain/service_locator.dart';
import 'package:infrastructure/github_git_repository/data/github_search_repositories_data.dart';

class GithubGitRepository {
  const GithubGitRepository();

  Future<GithubSearchRepositoriesData> searchRepositories(
      String keyword, int page) async {
    final httpClient = ServiceLocator.singleton().httpClient;
    final baseUrl =
        'https://api.github.com/search/repositories?q=$keyword&page=$page';

    final response = await httpClient.get(Uri.parse(baseUrl));
    final json = jsonDecode(response.body);
    return GithubSearchRepositoriesData.fromJson(json);
  }
}
