import 'package:flutter/material.dart';

/// アプリの状態を表すモデル
///
/// 現在のテーマモードと選択されたナビゲーターのインデックスを管理する
class AppModel {
  /// 現在のテーマモード（null不許可）
  final ThemeMode themeMode;

  /// 選択されたナビゲーターのインデックス（null不許可）
  final int selectedNavigatorIndex;

  /// 全てのフィールドを含むコンストラクタ
  AppModel({
    required this.themeMode,
    required this.selectedNavigatorIndex,
  });

  /// 新しい値でインスタンスをコピーする（themeModeは変更不可）
  AppModel copyWith({
    int? selectedNavigatorIndex,
    ThemeMode? themeMode,
  }) {
    return AppModel(
      themeMode: themeMode ?? this.themeMode,
      selectedNavigatorIndex:
          selectedNavigatorIndex ?? this.selectedNavigatorIndex,
    );
  }
}
