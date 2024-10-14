import 'package:http/http.dart' as http;

import 'package:domain/service_locator.dart';

import 'dummy_use_case/dummy_use_case_list.dart';
import 'package:github_browser_executable/main.dart' as exe;

void main() {
  ServiceLocator.init(
    http.Client(),
    DummyUseCaseList(),
  );

  exe.run();
}
