import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';
import 'package:github_browser_app/widgets/molecules/search_cancel_button.dart';

import '../atoms/app_text_field.dart';

class SearchAndConfirmBox extends StatefulWidget {
  const SearchAndConfirmBox({
    super.key,
    required this.onSearch,
    required this.onReset,
    required this.fetchSuggestions,
    required this.onChangeKeyword,
  });

  final FutureOr<List<String>> Function(String value) fetchSuggestions;
  final void Function() onReset;
  final void Function() onSearch;
  final void Function(String value) onChangeKeyword;

  @override
  State<SearchAndConfirmBox> createState() => _SearchAndConfirmBoxState();
}

class _SearchAndConfirmBoxState extends State<SearchAndConfirmBox> {
  final List<String> _options = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Orange',
    'Pineapple',
  ];

  var _currentText = '';
  var _submittedText = '';

  var _isSubmitted = false;

  void _onSelected(String value) {
    setState(() {
      _currentText = value;
    });
  }

  void _onSubmitted(String value) {
    widget.onSearch();
    setState(() {
      _submittedText = value;
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || _isSubmitted) {
          return const Iterable<String>.empty();
        }

        return widget.fetchSuggestions(textEditingValue.text);
      },
      onSelected: (String selection) => _onSelected(selection),
      displayStringForOption: (value) =>
          (value == _submittedText ? '[履歴]' : '') + value,
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
                isSearched: _isSubmitted,
                onChanged: (value) {
                  _currentText = value;
                  _isSubmitted = false;
                  widget.onChangeKeyword(value);
                },
                onSubmitted: () => _onSubmitted(_currentText),
                hintText: AppLocalizations.of(context).inputSearchWord,
              ),
            ),
            const SizedBox(width: 8),
            SearchCancelButton(
                isSearched: _isSubmitted,
                isKeywordEmpty: _currentText.isEmpty,
                onReset: widget.onReset,
                onSearch: () {
                  final text = fieldTextEditingController.text;
                  _onSubmitted(text);
                  fieldTextEditingController.text = text;

                  widget.onSearch();
                }),
          ],
        );
      },
    );
  }
}
