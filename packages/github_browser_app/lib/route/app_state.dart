import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_model.dart';

part 'app_state.g.dart';

@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  @override
  AppModel build() =>
      AppModel(themeMode: ThemeMode.system, selectedNavigatorIndex: 0);

  void changeThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
  }

  void changeNavigatorIndex(int index) {
    state = state.copyWith(selectedNavigatorIndex: index);
  }
}
