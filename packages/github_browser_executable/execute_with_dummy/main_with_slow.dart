import 'package:domain/service_locator.dart';
import 'package:github_browser_executable/app.dart' as exe;
import 'package:github_browser_executable/flavors.dart';
import 'package:http/http.dart' as http;

import 'dummy_use_case/dummy_small_data_use_case_list.dart';

void main() {
  ServiceLocator.init(
    http.Client(),
    DummySmallDataUseCaseList(),
  );

  F.appFlavor = Flavor.dev;
  exe.run();
}
