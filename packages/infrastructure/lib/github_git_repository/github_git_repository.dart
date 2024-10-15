import 'dart:convert';

import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:domain/service_locator.dart';
import 'package:http/http.dart';
import 'package:infrastructure/github_git_repository/data/github_search_repositories_data.dart';

class GithubGitRepository {
  const GithubGitRepository();

  static const _kErrorMessageForNoHost = "Failed host lookup: 'api.github.com'";

  /// リクエストしすぎてホストに拒否られた時のメッセージの最初の部分<br/>
  /// 原文： "API rate limit exceeded for XXX.XXX.XXX.XXX. (But here's the good news: Authenticated requests get a h..."<br/>
  /// The primary rate limit for unauthenticated requests is 60 requests per hour. (https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api?apiVersion=2022-11-28)
  static const _kErrorPrefixMessageForTooManyRequests =
      'API rate limit exceeded for';

  Future<GithubSearchRepositoriesData> searchRepositories(
      String keyword, int page) async {
    final httpClient = ServiceLocator.singleton().httpClient;
    final baseUrl =
        'https://api.github.com/search/repositories?q=$keyword&page=$page';

    late final Response response;
    try {
      response = await httpClient.get(Uri.parse(baseUrl));
    } catch (ex) {
      catchNetworkException(ex);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final message = json['message'];
    if (message != null) {
      catchExceptionFromGithub(message);
    }
    return GithubSearchRepositoriesData.fromJson(json);
  }

  void catchNetworkException(Object ex) {
    if (ex is ClientException) {
      if (ex.message == _kErrorMessageForNoHost) {
        throw NoHostException();
      }
    }
    throw ex;
  }

  void catchExceptionFromGithub(String message) {
    if (message.startsWith(_kErrorPrefixMessageForTooManyRequests)) {
      throw TooManyRequestsException();
    }
    throw InvalidDataException(message);
  }
}
