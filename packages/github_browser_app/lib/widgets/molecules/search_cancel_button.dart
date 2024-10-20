import 'package:flutter/material.dart';

class SearchCancelButton extends StatelessWidget {
  const SearchCancelButton({
    super.key,
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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: CircleAvatar(
        radius: 32,
        key: ValueKey<bool>(isSearched),
        child: IconButton(
            onPressed: isSearched
                ? onReset
                : isKeywordEmpty
                    ? null
                    : onSearch,
            icon: Icon(
              isSearched ? Icons.cancel : Icons.search,
              size: 32.0,
            )),
      ),
    );
  }
}
