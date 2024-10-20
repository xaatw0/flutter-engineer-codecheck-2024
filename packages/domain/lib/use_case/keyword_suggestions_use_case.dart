/// 検索キーワードをサジェストするユースケース
abstract class KeywordSuggestionsUseCase {
  /// 検索したワードを登録する
  void registerKeyword(String keyword);

  /// サジェストワードを取得する
  List<String> getSuggestion(String keyword);
}
