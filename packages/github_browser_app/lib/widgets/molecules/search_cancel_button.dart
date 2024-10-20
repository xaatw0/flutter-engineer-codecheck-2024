import 'package:flutter/material.dart';

class SearchCancelButton extends StatelessWidget {
  const SearchCancelButton({
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
    return CircleAvatar(
      radius: 32,
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
    );
  }
}
