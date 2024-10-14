part of 'search_repositories_page.dart';

class _KeywordTextField extends StatelessWidget {
  const _KeywordTextField({
    required this.isSearched,
    required this.onChanged,
    required this.onSubmitted,
  });

  final bool isSearched;
  final void Function(String value) onChanged;
  final void Function() onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Input search word',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted(),
      readOnly: isSearched,
    );
  }
}
