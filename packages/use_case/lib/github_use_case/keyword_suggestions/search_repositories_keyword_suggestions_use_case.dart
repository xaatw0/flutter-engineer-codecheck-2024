import 'package:domain/use_case/keyword_suggestions_use_case.dart';

/// Autocomplete用のお勧めキーワードを取得するクラス。基本的なキーワードとユーザ入力履歴を保持している。
class SearchRepositoriesKeywordSuggestionsUseCase
    implements KeywordSuggestionsUseCase {
  final List<String> _basicKeywords = [
    'ASP.NET',
    'AWS',
    'Angular',
    'Artificial Intelligence',
    'Azure'
        'Blockchain',
    'C#',
    'C',
    'C++',
    'CI/CD',
    'CSS3',
    'Cloud Computing',
    'Data Science',
    'Database',
    'DevOps',
    'Django',
    'Docker',
    'Electron',
    'Express.js',
    'Firebase',
    'Flask',
    'Flutter',
    'Go',
    'GraphQL',
    'HTML5',
    'Java',
    'JavaScript',
    'Kotlin',
    'Kubernetes',
    'Laravel',
    'Machine Learning',
    'Microservices',
    'MongoDB',
    'MySQL',
    'NoSQL',
    'Node.js',
    'PHP',
    'PostgreSQL',
    'Python',
    'REST API',
    'React',
    'Ruby on Rails',
    'Ruby',
    'Rust',
    'SQL',
    'Spring Boot',
    'Swift',
    'SwiftUI',
    'TypeScript',
    'Vue.js',
  ];

  final _userKeywordHistory = <String>[];

  static const _kMaxHistory = 10;

  @override
  void registerKeyword(String keyword) {
    if (_userKeywordHistory.contains(keyword)) {
      _userKeywordHistory.remove(keyword);
    }
    _userKeywordHistory.insert(0, keyword);

    if (_kMaxHistory < _userKeywordHistory.length) {
      _userKeywordHistory.removeRange(_kMaxHistory, _userKeywordHistory.length);
    }
  }

  @override
  List<String> getSuggestion(String keyword) {
    if (keyword.isEmpty) {
      return _userKeywordHistory;
    }

    return [..._basicKeywords, ..._userKeywordHistory]
        .where((e) => e.toLowerCase().contains(keyword.toLowerCase()))
        .toSet()
        .toList()
      ..sort();
  }
}
