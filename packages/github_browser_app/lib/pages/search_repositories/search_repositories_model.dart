import 'package:domain/entities/git_repository_entity.dart';

// search_repositories_model.dart

/// GitHubのリポジトリ検索結果を表すモデル
class SearchRepositoriesModel {
  /// 検索キーワード
  final String keyword;

  /// 検索開始
  final bool isSearched;

  /// ページ
  final int page;

  /// ローディング状態
  final bool isLoading;

  /// 検索結果として取得したリポジトリのリスト
  final List<GitRepositoryEntity> entities;

  /// 全てのフィールドを含むコンストラクタ
  const SearchRepositoriesModel({
    required this.keyword,
    required this.isSearched,
    required this.page,
    required this.isLoading,
    required this.entities,
  });

  /// copyWithメソッド。全てのフィールドをコピーできる
  SearchRepositoriesModel copyWith({
    String? keyword,
    bool? isSearched,
    int? page,
    bool? isLoading,
    List<GitRepositoryEntity>? entities,
  }) {
    return SearchRepositoriesModel(
      keyword: keyword ?? this.keyword,
      isSearched: isSearched ?? this.isSearched,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      entities: entities ?? this.entities,
    );
  }
}
