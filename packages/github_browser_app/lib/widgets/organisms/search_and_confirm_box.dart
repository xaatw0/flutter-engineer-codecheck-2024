import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/widgets/molecules/search_cancel_button.dart';

import '../atoms/app_text_field.dart';

class SearchAndConfirmBox extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || isSearched) {
          return const Iterable<String>.empty();
        }

        return fetchSuggestions(textEditingValue.text);
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
                isSearched: isSearched,
                onChanged: (value) {
                  onChangeKeyword(value);
                },
                onSubmitted: () => onSearch(),
                hintText: AppLocalizations.of(context).inputSearchWord,
              ),
            ),
            const SizedBox(width: 8),
            SearchCancelButton(
                isSearched: isSearched,
                isKeywordEmpty: isKeywordEmpty,
                onReset: onReset,
                onSearch: () {
                  onFieldSubmitted();
                  onSearch();
                }),
          ],
        );
      },
    );
  }
}
