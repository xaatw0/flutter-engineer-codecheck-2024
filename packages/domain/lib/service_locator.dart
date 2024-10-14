import 'package:http/http.dart' as http;

class ServiceLocator {
  static ServiceLocator? _instance;

  static ServiceLocator singleton() {
    return _instance ??= ServiceLocator._();
  }

  ServiceLocator._();

  static void setMock(ServiceLocator? mock) {
    _instance = mock;
  }

  final http.Client _httpClient = http.Client();
  http.Client get httpClient => singleton()._httpClient;
}
