import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_repositories_state.dart';

class SearchRepositoriesPage extends ConsumerWidget {
  const SearchRepositoriesPage({super.key});

  static const _kDescriptionLength = 50;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(searchRepositoriesStateProvider).isLoading;
    final items = ref.watch(searchRepositoriesStateProvider).entities;

    final isSearched = ref.read(searchRepositoriesStateProvider).isSearched;

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Input search word',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onChanged: (value) => ref
                            .read(searchRepositoriesStateProvider.notifier)
                            .changeKeyword(value),
                        onSubmitted: (value) {
                          ref
                              .read(searchRepositoriesStateProvider.notifier)
                              .loadRepositories();
                        },
                        readOnly: isSearched,
                      ),
                    ),
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 32,
                      child: IconButton(
                          onPressed: isSearched
                              ? () => ref
                                  .read(
                                      searchRepositoriesStateProvider.notifier)
                                  .reset()
                              : ref
                                      .read(searchRepositoriesStateProvider)
                                      .keyword
                                      .isEmpty
                                  ? null
                                  : () => ref
                                      .read(searchRepositoriesStateProvider
                                          .notifier)
                                      .loadRepositories(),
                          icon: Icon(
                            isSearched ? Icons.cancel : Icons.search,
                            size: 32.0,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: NotificationListener(
                onNotification: (ScrollEndNotification notification) {
                  final isScrollToEnd = notification.metrics.extentAfter == 0;

                  if (isScrollToEnd) {
                    ref
                        .read(searchRepositoriesStateProvider.notifier)
                        .loadRepositories();
                  }
                  return false;
                },
                child: ListView.builder(
                    itemCount: items.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == items.length) {
                        return SizedBox.square(
                            dimension: 32.0,
                            child: const CircularProgressIndicator());
                      }

                      final item = items[index];

                      final description = item.description.length <
                              _kDescriptionLength
                          ? item.description
                          : item.description.substring(0, _kDescriptionLength);

                      return ListTile(
                        leading: CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(item.authorImage),
                        ),
                        title: Text(item.repositoryName),
                        subtitle: Text(description),
                      );
                    }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
