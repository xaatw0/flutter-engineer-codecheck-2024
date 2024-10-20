import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/widgets/molecules/search_cancel_button.dart';

import '../atoms/app_text_field.dart';

class SearchAndConfirmBox extends StatefulWidget {
  const SearchAndConfirmBox({
    super.key,
    required this.isKeywordEmpty,
    required this.isSearched,
    required this.onSearch,
    required this.onReset,
    required this.fetchSuggestions,
    required this.onChangeKeyword,
  });

  /// 検索が実施されたか。検索後、テキストの変更ができなくなり、検索ボタンが削除ボタンに変更される
  final bool isSearched;

  /// キーワードが空白かどうか。空白の場合、検索ボタンが押せない
  final bool isKeywordEmpty;

  final FutureOr<List<String>> Function(String value) fetchSuggestions;
  final void Function() onReset;
  final void Function() onSearch;
  final void Function(String value) onChangeKeyword;

  @override
  State<SearchAndConfirmBox> createState() => _SearchAndConfirmBoxState();
}

class _SearchAndConfirmBoxState extends State<SearchAndConfirmBox> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || widget.isSearched) {
          return const Iterable<String>.empty();
        }

        return widget.fetchSuggestions(textEditingValue.text);
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                isSearched: widget.isSearched,
                onChanged: (value) {
                  widget.onChangeKeyword(value);
                },
                onSubmitted: () => widget.onSearch(),
                hintText: AppLocalizations.of(context).inputSearchWord,
              ),
            ),
            const SizedBox(width: 8),
            SearchCancelButton(
                isSearched: widget.isSearched,
                isKeywordEmpty: widget.isKeywordEmpty,
                onReset: widget.onReset,
                onSearch: () {
                  onFieldSubmitted();
                  widget.onSearch();
                }),
          ],
        );
      },
    );
  }
}
