import 'package:flutter_test/flutter_test.dart';
import 'package:use_case/github_use_case/keyword_suggestions/search_repositories_keyword_suggestions_use_case.dart';

main() {
  group('ユーザ履歴', () {
    test('ユーザ履歴', () {
      final target = SearchRepositoriesKeywordSuggestionsUseCase();
      target.registerKeyword('keyword1');
      expect(target.getSuggestion('').length, 1);

      target.registerKeyword('keyword2');
      expect(target.getSuggestion(''), ['keyword2', 'keyword1']);

      target.registerKeyword('keyword1');
      expect(target.getSuggestion(''), ['keyword1', 'keyword2']);
    });

    test('最大数', () {
      final target = SearchRepositoriesKeywordSuggestionsUseCase();
      for (int i = 0; i < 10; i++) {
        target.registerKeyword('keyword$i');
      }

      expect(target.getSuggestion('').length, 10);
      expect(target.getSuggestion('').first, 'keyword9');
      expect(target.getSuggestion('').last, 'keyword0');

      target.registerKeyword('keyword10');
      expect(target.getSuggestion('').length, 10);
      expect(target.getSuggestion('').first, 'keyword10');
      expect(target.getSuggestion('').last, 'keyword1');
    });
  });
  test('おすすめ', () {
    final target = SearchRepositoriesKeywordSuggestionsUseCase();
    expect(target.getSuggestion('java').length, 2);
    expect(target.getSuggestion('Java').length, 2);
    expect(target.getSuggestion('JAVA').length, 2);

    expect(target.getSuggestion('go'), ['Django', 'Go', 'MongoDB']);
  });

  test('混在', () {
    final target = SearchRepositoriesKeywordSuggestionsUseCase();
    target.registerKeyword('DaiGo');
    target.registerKeyword('Godzilla');

    expect(target.getSuggestion('go'),
        ['DaiGo', 'Django', 'Go', 'Godzilla', 'MongoDB']);
  });
}
