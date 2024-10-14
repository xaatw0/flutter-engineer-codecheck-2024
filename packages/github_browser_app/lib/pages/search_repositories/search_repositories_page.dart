import 'package:domain/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchRepositoriesPage extends ConsumerWidget {
  const SearchRepositoriesPage({super.key});

  static const _kDescriptionLength = 50;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyData = ServiceLocator.singleton()
        .useCaseList
        .getSearchRepositoriesUseCase()
        .loadGitRepositories('keyword', 0);

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
                          hintText: 'Search word',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {},
                        onSubmitted: (value) {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 32,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_rounded,
                            size: 32.0,
                          )),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: dummyData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    final data = snapshot.data!;

                    return Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];

                              final description =
                                  item.description.length < _kDescriptionLength
                                      ? item.description
                                      : item.description
                                          .substring(0, _kDescriptionLength);

                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 32,
                                  backgroundImage:
                                      NetworkImage(item.authorImage),
                                ),
                                title: Text(item.repositoryName),
                                subtitle: Text(description),
                              );
                            }));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
