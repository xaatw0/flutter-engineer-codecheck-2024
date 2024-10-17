import 'package:domain/entities/git_repository_entity.dart';
import 'package:domain/service_locator.dart';
import 'package:domain/use_case/search_repositories_use_case.dart';
import 'package:domain/use_case/use_case_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_browser_app/pages/search_repositories/ask_before_reset.dart';
import 'package:github_browser_app/pages/search_repositories/search_repositories_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'search_repositories_state_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<UseCaseList>(),
  MockSpec<SearchRepositoriesUseCase>(),
  MockSpec<AskIfReset>(),
  MockSpec<BuildContext>()
])
void main() {
  final mockSearchRepositoriesUseCase = MockSearchRepositoriesUseCase();
  final mockUserCaseList = MockUseCaseList();
  when(mockUserCaseList.getSearchRepositoriesUseCase())
      .thenReturn(mockSearchRepositoriesUseCase);
  ServiceLocator.init(http.Client(), mockUserCaseList);

  late ProviderContainer container;

  final searchRepositoriesState = SearchRepositoriesState();
  setUp(() {
    container = ProviderContainer(); // ProviderContainerを作成
  });
  tearDown(() {
    container.dispose(); // テスト終了後にProviderContainerを破棄
  });

  test('Initial state should have default values', () {
    final initialState = searchRepositoriesState.build();
    expect(initialState.keyword, '');
    expect(initialState.isSearched, false);
    expect(initialState.page, 1);
    expect(initialState.isLoading, false);
    expect(initialState.entities, []);
  });

  test('changeKeyword updates the keyword in the state', () {
    final initState = container.read(searchRepositoriesStateProvider);
    expect(initState.keyword, '');

    container
        .read(searchRepositoriesStateProvider.notifier)
        .changeKeyword('flutter');

    final updatedState = container.read(searchRepositoriesStateProvider);
    expect(updatedState.keyword, 'flutter');
  });

  test('loadRepositories updates state with repositories', () async {
    final repositories = [
      for (int i = 0; i < 2; i++)
        GitRepositoryEntity(
            authorName: '',
            repositoryName: 'repository$i',
            description: '',
            authorImage: '',
            stargazersCount: 0,
            forksCount: 0,
            issuesCount: 0,
            watchersCount: 0,
            lastUpdatedAt: DateTime.now())
    ];

    final initialState = container.read(searchRepositoriesStateProvider);
    expect(initialState.keyword, '');
    expect(initialState.isSearched, false);
    expect(initialState.page, 1);
    expect(initialState.isLoading, false);
    expect(initialState.entities, []);

    when(mockSearchRepositoriesUseCase.loadGitRepositories(any, any))
        .thenAnswer((_) async => repositories);

    final future = container
        .read(searchRepositoriesStateProvider.notifier)
        .loadRepositories();

    final beforeLoading = container.read(searchRepositoriesStateProvider);
    expect(beforeLoading.keyword, '');
    expect(beforeLoading.isSearched, true);
    expect(beforeLoading.page, 1);
    expect(beforeLoading.isLoading, true);
    expect(beforeLoading.entities, []);

    await future;
    verify(mockSearchRepositoriesUseCase.loadGitRepositories('', 1)).called(1);

    final afterLoading = container.read(searchRepositoriesStateProvider);
    expect(afterLoading.keyword, '');
    expect(afterLoading.isSearched, true);
    expect(afterLoading.page, 2);
    expect(afterLoading.isLoading, false);
    expect(afterLoading.entities.length, 2);
    expect(afterLoading.entities, repositories);

    await container
        .read(searchRepositoriesStateProvider.notifier)
        .loadRepositories();
    verify(mockSearchRepositoriesUseCase.loadGitRepositories('', 2)).called(1);

    final afterSecondLoading = container.read(searchRepositoriesStateProvider);
    expect(afterSecondLoading.page, 3);
    expect(afterSecondLoading.entities.length, 4);
  });

  test('resets', () async {
    final repositories = [
      for (int i = 0; i < 2; i++)
        GitRepositoryEntity(
            authorName: '',
            repositoryName: 'repository$i',
            description: '',
            authorImage: '',
            stargazersCount: 0,
            forksCount: 0,
            issuesCount: 0,
            watchersCount: 0,
            lastUpdatedAt: DateTime.now())
    ];

    when(mockSearchRepositoriesUseCase.loadGitRepositories(any, any))
        .thenAnswer((_) async => repositories);

    container
        .read(searchRepositoriesStateProvider.notifier)
        .changeKeyword('keyword');
    await container
        .read(searchRepositoriesStateProvider.notifier)
        .loadRepositories();

    final afterLoading = container.read(searchRepositoriesStateProvider);
    expect(afterLoading.keyword, 'keyword');
    expect(afterLoading.isSearched, true);
    expect(afterLoading.page, 2);
    expect(afterLoading.isLoading, false);
    expect(afterLoading.entities.length, 2);
    expect(afterLoading.entities, repositories);

    container.read(searchRepositoriesStateProvider.notifier).reset();
    final afterReset = container.read(searchRepositoriesStateProvider);
    expect(afterReset.keyword, 'keyword');
    expect(afterReset.isSearched, false);
    expect(afterReset.page, 1);
    expect(afterReset.isLoading, false);
    expect(afterReset.entities.length, 0);
  });

  group('resetAfterAsk', () {
    final askIfReset = MockAskIfReset();
    final notifier =
        () => container.read(searchRepositoriesStateProvider.notifier);
    final state = () => container.read(searchRepositoriesStateProvider);

    final context = MockBuildContext();

    test('false: キャンセルを押すと、リセットしない', () async {
      notifier().changeKeyword('keyword');
      when(askIfReset.askIfReset(context, 'keyword'))
          .thenAnswer((_) async => false);
      expect(state().entities.length, 0);
      await notifier().loadRepositories();
      expect(state().keyword, 'keyword');
      expect(state().entities.length, 2);

      await notifier().resetAfterAsk(askIfReset, context);
      expect(state().entities.length, 2);
    });

    test('true： リセットする', () async {
      when(askIfReset.askIfReset(context, 'keyword'))
          .thenAnswer((_) async => true);
      expect(state().entities.length, 0);
      notifier().changeKeyword('keyword');
      await notifier().loadRepositories();
      expect(state().entities.length, 2);

      await notifier().resetAfterAsk(askIfReset, context);
      expect(state().keyword, 'keyword');
      expect(state().entities.length, 0);
    });
  });
}
