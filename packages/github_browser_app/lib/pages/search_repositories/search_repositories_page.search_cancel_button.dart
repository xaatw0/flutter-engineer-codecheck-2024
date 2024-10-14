part of 'search_repositories_page.dart';

class _SearchCancelButton extends StatelessWidget {
  const _SearchCancelButton({
    required this.isSearched,
    required this.isKeywordEmpty,
    required this.onReset,
    required this.onSearch,
  });

  final bool isSearched;
  final bool isKeywordEmpty;
  final void Function() onReset;
  final void Function() onSearch;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: isSearched
            ? onReset
            : isKeywordEmpty
                ? null
                : onSearch,
        icon: Icon(
          isSearched ? Icons.cancel : Icons.search,
          size: 32.0,
        ));
  }
}
