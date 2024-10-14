part of 'search_repositories_page.dart';

class _RepositoryTile extends StatelessWidget {
  const _RepositoryTile({
    required this.item,
    required GlobalKey<ModelessDrawerState<GitRepositoryEntity>> kerDrawer,
  }) : _kerDrawer = kerDrawer;

  final GitRepositoryEntity item;
  final GlobalKey<ModelessDrawerState<GitRepositoryEntity>> _kerDrawer;

  static const _kDescriptionLength = 50;

  @override
  Widget build(BuildContext context) {
    final description = item.description.length < _kDescriptionLength
        ? item.description
        : item.description.substring(0, _kDescriptionLength);
    return ListTile(
      leading: CircleAvatar(
        radius: 32,
        backgroundImage: NetworkImage(item.authorImage),
      ),
      title: Text(item.repositoryName),
      subtitle: Text(description),
      onTap: () => _kerDrawer.currentState
        ?..changeValue(item)
        ..open(),
    );
  }
}
