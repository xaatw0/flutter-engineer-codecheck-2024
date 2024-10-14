import 'package:domain/entities/git_repository_entity.dart';

abstract class SearchRepositoriesUseCase {
  List<GitRepositoryEntity> loadGitRepositories(String keyword, int page);
}
