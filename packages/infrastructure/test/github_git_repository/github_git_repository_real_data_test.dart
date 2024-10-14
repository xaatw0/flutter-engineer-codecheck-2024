import 'package:domain/service_locator.dart';
import 'package:domain/use_case/use_case_list.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/github_git_repository/github_git_repository.dart';
import 'package:mockito/annotations.dart';

import 'github_git_repository_real_data_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UseCaseList>(),
])
void main() {
  test('実データの読み込み', () async {
    ServiceLocator.init(
      http.Client(),
      MockUseCaseList(),
    );

    final target = GithubGitRepository();
    final result = await target.searchRepositories('flutter', 1);
    expect(result.totalCount,
        greaterThanOrEqualTo(750330)); // flutterのレポジトリが増えている前提
  });
}
