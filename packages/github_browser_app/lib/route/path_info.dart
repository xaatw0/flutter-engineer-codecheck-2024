import 'package:flutter/material.dart';
import 'package:github_browser_app/gen_l10n/app_localizations.dart';

/// 画面やルートに関する情報を保持するデータモデルクラス
///
/// このクラスは、特定の画面に関連するパス（URLパスやルート名）
/// ウィジェット、アイコン、タイトルを取得するための関数を持っています。
class PathInfo {
  /// コンストラクタ
  ///
  /// - `path`: ルートのパス（URLやルート名など）
  /// - `widget`: 表示するウィジェット（画面の内容）
  /// - `iconData`: 画面やルートに関連するアイコンデータ
  /// - `getTitle`: アプリのローカライズに応じたタイトルを取得する関数
  const PathInfo(
    this.path, // ルートパス（例: "/home"など）
    this.widget, // 表示されるウィジェット（画面の内容）
    this.iconData, // ルートに関連するアイコン
    this.getTitle, // タイトルを取得する関数
  );

  /// ルートのパス（URLやルート名）
  final String path;

  /// ルートに表示されるウィジェット（画面）
  final Widget widget;

  /// ルートに関連するアイコン（UIに表示されるアイコン）
  final IconData iconData;

  /// ローカライズされたタイトルを取得するための関数
  ///
  /// `AppLocalizations` を引数として渡し、対応するローカライズされた
  /// タイトルを返します。これにより、多言語対応でタイトル表示が可能になります。
  final String Function(AppLocalizations appLoc) getTitle;
}
