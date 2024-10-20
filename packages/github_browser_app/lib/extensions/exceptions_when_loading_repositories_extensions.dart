import 'package:domain/exceptions/exceptions_when_loading_repositories.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

/// レポジトリ検索時のエラーに対するエラーメッセージ
extension ExceptionsWhenLoadingRepositoriesExtensions
    on ExceptionsWhenLoadingRepositories {
  String getMessage(AppLocalizations appLoc) {
    return switch (this) {
      NoHostException() => appLoc.hostNotFoundPleaseCheckNetwork,
      TooManyRequestsException() => appLoc.tooManyRequestsPleaseWait,
      InvalidDataException() => appLoc.invalidDataFormatReceived,
    };
  }
}
