// ベースのシールドクラス
sealed class ExceptionsWhenLoadingRepositories implements Exception {
  final String message;
  ExceptionsWhenLoadingRepositories(
      [this.message = 'An error occurred while loading repositories.']);

  @override
  String toString() => message;
}

/// ネットワークに繋がっていない状態の時
class NoHostException extends ExceptionsWhenLoadingRepositories {
  NoHostException([String message = 'No network connection available.'])
      : super(message);
}

/// アクセスしすぎで、サーバから拒否されたとき
class TooManyRequestsException extends ExceptionsWhenLoadingRepositories {
  TooManyRequestsException(
      [String message =
          'Too many requests. The server has rejected your request.'])
      : super(message);
}

/// 不正なデータを受け取ったとき
class InvalidDataException extends ExceptionsWhenLoadingRepositories {
  final Object innerException;

  InvalidDataException(this.innerException,
      [String message = 'Invalid data received from the server.'])
      : super(message);
}
