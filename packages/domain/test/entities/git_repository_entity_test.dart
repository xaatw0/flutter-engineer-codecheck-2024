// git_repository_entity_test.dart

import 'package:domain/entities/git_repository_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  group('GitRepositoryEntity Tests', () {
    test('1. コンストラクタからクラスを作成し、全てのフィールドをテスト', () {
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

      expect(repository.authorName, 'flutter');
      expect(repository.repositoryName, 'flutter/flutter');
      expect(repository.description,
          'Flutter makes it easy and fast to build beautiful apps for mobile and beyond');
      expect(repository.authorImage,
          'https://avatars.githubusercontent.com/u/14101776?v=4');
      expect(repository.stargazersCount, 165427);
      expect(repository.forksCount, 27304);
      expect(repository.issuesCount, 12695);
      expect(repository.watchersCount, 165427);
      expect(repository.lastUpdatedAt, DateTime.parse('2024-10-13T20:56:54Z'));
    });

    test('2. JSONからクラスを作成し、Jsonに変換して内容を確認', () {
      final jsonString = '''
{
"authorName":"flutter",
"repositoryName":"flutter/flutter",
"description":"Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
"authorImage":"https://avatars.githubusercontent.com/u/14101776?v=4",
"stargazersCount":165427,
"forksCount":27304,
"issuesCount":12695,
"watchersCount":165427,
"lastUpdatedAt":"2024-10-13T20:56:54Z"
}
''';

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final repository = GitRepositoryEntity.fromJson(jsonMap);

      final toJsonMap = repository.toJson();
      final expectedJsonMap = {
        "authorName": "flutter",
        "repositoryName": "flutter/flutter",
        "description":
            "Flutter makes it easy and fast to build beautiful apps for mobile and beyond",
        "authorImage": "https://avatars.githubusercontent.com/u/14101776?v=4",
        "stargazersCount": 165427,
        "forksCount": 27304,
        "issuesCount": 12695,
        "watchersCount": 165427,
        "lastUpdatedAt": "2024-10-13T20:56:54.000Z"
      };

      expect(toJsonMap, expectedJsonMap);
    });
  });
}
