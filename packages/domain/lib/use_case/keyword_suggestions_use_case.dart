abstract class KeywordSuggestionsUseCase {
  void registerKeyword(String keyword);
  List<String> getSuggestion(String keyword);
}
