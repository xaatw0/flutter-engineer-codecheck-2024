import 'dart:io';
import 'package:domain/service_locator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/github_git_repository/github_git_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'github_git_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<http.Client>(),
  MockSpec<http.Response>(),
  MockSpec<ServiceLocator>()
])
void main() {
  final file =
      File('test/github_git_repository/github_git_repository_test.json');

  test('ファイルの存在', () {
    expect(file.existsSync(), true);
  });

  test('読み込みデータの変換', () async {
    final mockResponse = MockResponse();
    when(mockResponse.body).thenReturn(file.readAsStringSync());

    final mockHttpClient = MockClient();
    when(
      mockHttpClient.get(Uri.parse(
          'https://api.github.com/search/repositories?q=flutter&page=1')),
    ).thenAnswer((_) async => mockResponse);

    final mockServiceLocator = MockServiceLocator();
    when(mockServiceLocator.httpClient).thenReturn(mockHttpClient);
    ServiceLocator.setMock(mockServiceLocator);

    final target = GithubGitRepository();
    final result = await target.searchRepositories('flutter', 1);
    expect(result.totalCount, 750330);
  });

  test('引数', () async {
    final mockResponse = MockResponse();
    when(mockResponse.body).thenReturn(file.readAsStringSync());

    final mockHttpClient = MockClient();
    when(
      mockHttpClient.get(any),
    ).thenAnswer((_) async => mockResponse);

    final mockServiceLocator = MockServiceLocator();
    when(mockServiceLocator.httpClient).thenReturn(mockHttpClient);
    ServiceLocator.setMock(mockServiceLocator);

    final target = GithubGitRepository();

    // 実行前は呼ばれておらず、実行するとcalledで確認され、確認すると呼ばれていない状態になることを確認
    verifyNever(mockHttpClient.get(Uri.parse(
        'https://api.github.com/search/repositories?q=keyword&page=1')));
    target.searchRepositories('keyword', 1);
    verify(mockHttpClient.get(Uri.parse(
            'https://api.github.com/search/repositories?q=keyword&page=1')))
        .called(1);
    verifyNever(mockHttpClient.get(Uri.parse(
        'https://api.github.com/search/repositories?q=keyword&page=1')));

    target.searchRepositories('flutter', 1);
    verify(mockHttpClient.get(Uri.parse(
            'https://api.github.com/search/repositories?q=flutter&page=1')))
        .called(1);

    target.searchRepositories('flutter', 2);
    verify(mockHttpClient.get(Uri.parse(
            'https://api.github.com/search/repositories?q=flutter&page=2')))
        .called(1);
  });

  test('実データの読み込み', () async {
    ServiceLocator.setMock(null);

    final target = GithubGitRepository();
    final result = await target.searchRepositories('flutter', 1);
    expect(result.totalCount,
        greaterThanOrEqualTo(750330)); // flutterのレポジトリが増えている前提
  });
}
