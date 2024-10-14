import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:github_browser_app/pages/search_repositories/search_repositories_page.dart';
import 'package:domain/service_locator.dart';

import 'dummy_use_case/dummy_use_case_list.dart';

void main() {
  ServiceLocator.init(
    http.Client(),
    DummyUseCaseList(),
  );

  runApp(const SearchRepositoriesPage());
}
