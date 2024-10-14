import 'package:domain/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchRepositoriesPage extends ConsumerWidget {
  const SearchRepositoriesPage({super.key});

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
              Row(
                children: [
                  Expanded(child: TextField()),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
                ],
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
                      itemBuilder: (context, index) => ListTile(
                        title: Text(data[index].repositoryName),
                      ),
                    ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
