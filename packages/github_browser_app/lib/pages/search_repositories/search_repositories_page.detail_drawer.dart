part of 'search_repositories_page.dart';

class _DetailDrawer extends StatelessWidget {
  const _DetailDrawer({
    required GlobalKey<ModelessDrawerState<GitRepositoryEntity>> kerDrawer,
  }) : _kerDrawer = kerDrawer;

  final GlobalKey<ModelessDrawerState<GitRepositoryEntity>> _kerDrawer;

  @override
  Widget build(BuildContext context) {
    return ModelessDrawer<GitRepositoryEntity>(
        key: _kerDrawer,
        width: MediaQuery.sizeOf(context).width * 2 / 3,
        builder: (BuildContext context, GitRepositoryEntity? item) {
          if (item == null) {
            return const Text('No data');
          }

          final pairs = [
            (Icons.star, item.stargazersCount),
            (Icons.fork_right, item.forksCount),
            (Icons.remove_red_eye, item.watchersCount),
            (Icons.question_mark, item.issuesCount),
          ];

          return Column(
            children: [
              Text(
                item.repositoryName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(item.authorImage),
              ),
              Text(item.authorName),
              const SizedBox(height: 16),
              if (context.responsive(true, medium: false))
                for (final (icon, count) in pairs) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon),
                      Text('$count'),
                    ],
                  ),
                ],
              if (context.responsive(false, medium: true))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final (icon, count) in pairs) ...[
                      Icon(icon),
                      Text('$count'),
                      const SizedBox(width: 8)
                    ]
                  ],
                ),
              const SizedBox(height: 32),
              Text(item.description),
            ],
          );
        });
  }
}
