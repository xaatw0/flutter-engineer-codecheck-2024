import 'package:domain/use_case/use_case_list.dart';
import 'package:http/http.dart' as http;

class ServiceLocator {
  static late final ServiceLocator _instance;

  static ServiceLocator singleton() {
    return _instance;
  }

  ServiceLocator._(
    this._httpClient,
    this._useCaseList,
  );

  static void init(http.Client httpClient, UseCaseList useCaseList) {
    _instance = ServiceLocator._(httpClient, useCaseList);
  }

  final http.Client _httpClient;
  http.Client get httpClient => singleton()._httpClient;

  final UseCaseList _useCaseList;
  UseCaseList get useCaseList => singleton()._useCaseList;
}
