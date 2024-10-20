import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/widgets/molecules/search_cancel_button.dart';

import '../atoms/app_text_field.dart';

class SearchAndConfirmBox extends StatelessWidget {
  const SearchAndConfirmBox({
    super.key,
    required this.isKeywordEmpty,
    required this.onSearch,
    required this.onReset,
    required this.fetchSuggestions,
    required this.onChangeKeyword,
    required this.isFuncSearched,
  });

  /// 検索が実施されたか。検索後、テキストの変更ができなくなり、検索ボタンが削除ボタンに変更される。
  /// 変数として渡すと作成時点の値が取得される。optionsBuilderが実施された瞬間の値が欲しいため、
  /// 関数を設定する。
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
                isReadOnly: isFuncSearched(),
                onChanged: onChangeKeyword,
                onSubmitted: () => onSearch(),
                hintText: AppLocalizations.of(context).inputSearchWord,
              ),
            ),
            const SizedBox(width: 8),
            SearchCancelButton(
                isSearched: isFuncSearched(),
                isKeywordEmpty: isKeywordEmpty,
                onReset: onReset,
                onSearch: () {
                  onSearch();

                  // キーワードを入れ直すと、optionsBuilder が動作する
                  // 動作させないと、サジェストワードが表示されたままになる
                  final keyword = fieldTextEditingController.text;
                  fieldTextEditingController.text = keyword;
                }),
          ],
        );
      },
    );
  }
}
