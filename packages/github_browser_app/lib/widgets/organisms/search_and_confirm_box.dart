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
    required this.isFuncSearched,
  });

  /// 検索が実施されたか。検索後、テキストの変更ができなくなり、検索ボタンが削除ボタンに変更される
  final bool isSearched;

  final bool Function() isFuncSearched;

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
        print('isSearched in box: $isSearched');
        print('isFuncSearched in box: ${isFuncSearched()}');
        if (textEditingValue.text.isEmpty || isFuncSearched()) {
          return const Iterable<String>.empty();
        }

        return fetchSuggestions(textEditingValue.text);
      },
      onSelected: onChangeKeyword,
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
                isReadOnly: isSearched,
                onChanged: onChangeKeyword,
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
                  print('onSearch start');
                  onSearch();
                  final keyword = fieldTextEditingController.text;
                  onFieldSubmitted();
                  fieldTextEditingController.text = keyword;
                  print('onSearch end');
                }),
          ],
        );
      },
    );
  }
}
