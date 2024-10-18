import 'package:flutter/material.dart';
import 'package:github_browser_app/route/app_theme_color.dart';

/// アプリの状態を表すモデル
///
/// 現在のテーマモードと選択されたナビゲーターのインデックスを管理する
class AppModel {
  /// 現在のテーマモード（null不許可）
  final ThemeMode themeMode;

  /// 選択されたナビゲーターのインデックス（null不許可）
  final int selectedNavigatorIndex;

  /// アプリ全体のカラースキームのベース
  final AppThemeColor appThemeColor;

  /// MaterialYouが有効か<br/>
  /// true: 有効 false:無効
  final bool isMaterialYouAvailable;

  /// 全てのフィールドを含むコンストラクタ
  AppModel({
    required this.themeMode,
    required this.selectedNavigatorIndex,
    required this.appThemeColor,
    required this.isMaterialYouAvailable,
  });

  /// 新しい値でインスタンスをコピーする
  AppModel copyWith({
    int? selectedNavigatorIndex,
    ThemeMode? themeMode,
    AppThemeColor? appThemeColor,
    bool? isMaterialYouAvailable,
  }) {
    return AppModel(
      themeMode: themeMode ?? this.themeMode,
      selectedNavigatorIndex:
          selectedNavigatorIndex ?? this.selectedNavigatorIndex,
      appThemeColor: appThemeColor ?? this.appThemeColor,
      isMaterialYouAvailable:
          isMaterialYouAvailable ?? this.isMaterialYouAvailable,
    );
  }
}
