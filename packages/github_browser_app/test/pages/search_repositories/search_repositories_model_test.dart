// search_repositories_model_test.dart

import 'package:domain/entities/git_repository_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_browser_app/pages/search_repositories/search_repositories_model.dart';

void main() {
  group('SearchRepositoriesModel Tests', () {
    test('1. コンストラクタからクラスを作成し、全てのフィールドをテスト', () {
      final repository1 = GitRepositoryEntity(
        authorName: 'flutter',
        repositoryName: 'flutter/flutter',
        description:
            'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
        authorImage: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        stargazersCount: 165427,
        forksCount: 27304,
        issuesCount: 12695,
        watchersCount: 165427,
        lastUpdatedAt: DateTime.parse('2024-10-13T20:56:54Z'),
      );

      final repository2 = GitRepositoryEntity(
        authorName: 'iampawan',
        repositoryName: 'iampawan/FlutterExampleApps',
        description: '[Example APPS] Basic Flutter apps, for flutter devs.',
        authorImage: 'https://avatars.githubusercontent.com/u/12619420?v=4',
        stargazersCount: 20505,
        forksCount: 3769,
        issuesCount: 37,
        watchersCount: 20505,
        lastUpdatedAt: DateTime.parse('2024-08-09T20:51:30Z'),
      );

      final model = SearchRepositoriesModel(
        keyword: 'flutter',
        isSearched: false,
        page: 1,
        isLoading: false,
        entities: [repository1, repository2],
      );

      // フィールドの検証
      expect(model.keyword, 'flutter');
      expect(model.isLoading, false);
      expect(model.entities.length, 2);

      // 1つ目のリポジトリの検証
      final repo1 = model.entities[0];
      expect(repo1.authorName, 'flutter');
      expect(repo1.repositoryName, 'flutter/flutter');
      expect(repo1.description,
          'Flutter makes it easy and fast to build beautiful apps for mobile and beyond');
      expect(repo1.authorImage,
          'https://avatars.githubusercontent.com/u/14101776?v=4');
      expect(repo1.stargazersCount, 165427);
      expect(repo1.forksCount, 27304);
      expect(repo1.issuesCount, 12695);
      expect(repo1.watchersCount, 165427);
      expect(repo1.lastUpdatedAt, DateTime.parse('2024-10-13T20:56:54Z'));

      // 2つ目のリポジトリの検証
      final repo2 = model.entities[1];
      expect(repo2.authorName, 'iampawan');
      expect(repo2.repositoryName, 'iampawan/FlutterExampleApps');
      expect(repo2.description,
          '[Example APPS] Basic Flutter apps, for flutter devs.');
      expect(repo2.authorImage,
          'https://avatars.githubusercontent.com/u/12619420?v=4');
      expect(repo2.stargazersCount, 20505);
      expect(repo2.forksCount, 3769);
      expect(repo2.issuesCount, 37);
      expect(repo2.watchersCount, 20505);
      expect(repo2.lastUpdatedAt, DateTime.parse('2024-08-09T20:51:30Z'));
    });

    test('2. copyWithで更新されることを、変数を一つずつ実行して確認', () {
      final repository = GitRepositoryEntity(
        authorName: 'flutter',
        repositoryName: 'flutter/flutter',
        description:
            'Flutter makes it easy and fast to build beautiful apps for mobile and beyond',
        authorImage: 'https://avatars.githubusercontent.com/u/14101776?v=4',
        stargazersCount: 165427,
        forksCount: 27304,
        issuesCount: 12695,
        watchersCount: 165427,
        lastUpdatedAt: DateTime.parse('2024-10-13T20:56:54Z'),
      );

      final originalModel = SearchRepositoriesModel(
        keyword: 'flutter',
        isSearched: false,
        page: 1,
        isLoading: false,
        entities: [repository],
      );

      // keywordの更新
      final updatedKeywordModel = originalModel.copyWith(
        keyword: 'dart',
      );
      expect(updatedKeywordModel.keyword, 'dart');
      expect(updatedKeywordModel.isLoading, originalModel.isLoading);
      expect(updatedKeywordModel.entities, originalModel.entities);

      // isLoadingの更新
      final updatedIsLoadingModel = originalModel.copyWith(
        isLoading: true,
      );
      expect(updatedIsLoadingModel.isLoading, true);
      expect(updatedIsLoadingModel.keyword, originalModel.keyword);
      expect(updatedIsLoadingModel.entities, originalModel.entities);

      // entitiesの更新
      final newRepository = GitRepositoryEntity(
        authorName: 'new_author',
        repositoryName: 'new_author/new_repo',
        description: 'New repository description',
        authorImage: 'https://avatars.githubusercontent.com/u/00000000?v=4',
        stargazersCount: 5000,
        forksCount: 1000,
        issuesCount: 100,
        watchersCount: 5000,
        lastUpdatedAt: DateTime.parse('2024-11-01T10:00:00Z'),
      );

      final updatedEntitiesModel = originalModel.copyWith(
        entities: [newRepository],
      );
      expect(updatedEntitiesModel.entities.length, 1);
      expect(updatedEntitiesModel.entities[0].authorName, 'new_author');
      expect(updatedEntitiesModel.entities[0].repositoryName,
          'new_author/new_repo');
      expect(updatedEntitiesModel.entities[0].description,
          'New repository description');
      expect(updatedEntitiesModel.entities[0].authorImage,
          'https://avatars.githubusercontent.com/u/00000000?v=4');
      expect(updatedEntitiesModel.entities[0].stargazersCount, 5000);
      expect(updatedEntitiesModel.entities[0].forksCount, 1000);
      expect(updatedEntitiesModel.entities[0].issuesCount, 100);
      expect(updatedEntitiesModel.entities[0].watchersCount, 5000);
      expect(updatedEntitiesModel.entities[0].lastUpdatedAt,
          DateTime.parse('2024-11-01T10:00:00Z'));
      expect(updatedEntitiesModel.keyword, originalModel.keyword);
      expect(updatedEntitiesModel.isLoading, originalModel.isLoading);
    });
  });
}
