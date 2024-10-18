import 'package:flutter/material.dart';
import 'package:github_browser_app/route/app_theme_color.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_model.dart';

part 'app_state.g.dart';

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  @override
  AppModel build() => AppModel(
        themeMode: ThemeMode.system,
        selectedNavigatorIndex: 0,
        appThemeColor: AppThemeColor.magenta,
        isMaterialYouAvailable: false,
        lightMaterialYouColor: null,
        dartMaterialYouColor: null,
      );

  /// ライトモード・ダークモードの変更
  void changeThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
  }

  /// bottomNavigationBarの選択された項目のインデックスを変更
  void changeNavigatorIndex(int index) {
    state = state.copyWith(selectedNavigatorIndex: index);
  }

  /// 選択されたアプリのテーマカラーのベースカラーを変更
  void changeAppThemeColor(AppThemeColor appThemeColor) {
    state = state.copyWith(appThemeColor: appThemeColor);
  }

  /// MaterialYouが対応かを設定<br/>
  /// true: 対応 false:非対応
  void changeMaterialYouAvailable(bool isMaterialYouAvailable) {
    state = state.copyWith(isMaterialYouAvailable: isMaterialYouAvailable);
  }

  /// MaterialYou時のプライマリーカラーを設定
  void changeMaterialYouColor(
      Color? lightMaterialYouColor, Color? dartMaterialYouColor) {
    state = state.copyWith(
      lightMaterialYouColor: lightMaterialYouColor,
      dartMaterialYouColor: dartMaterialYouColor,
    );
  }
}
