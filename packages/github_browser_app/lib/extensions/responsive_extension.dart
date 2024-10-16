import 'package:flutter/material.dart';

/// https://m3.material.io/foundations/layout/applying-layout/window-size-classes
enum WindowSize {
  /// Extra-large: 1600px以上の幅を持つデスクトップ（ウルトラワイドを含む）
  xLarge(1600.0),

  /// Large: 幅が1200pxから1599pxのデスクトップ
  large(1200.0),

  /// Expanded: 幅が840pxから1199pxのデバイスで、ランドスケープモードの電話や、ランドスケープモードのタブレット、展開された状態の折り畳み可能デバイスを含む
  expanded(840.0),

  /// Medium: 幅が600pxから839pxのデバイスで、ポートレートモードのタブレットや、展開された状態の折り畳み可能デバイスを含む
  medium(600.0),

  /// Compact: 幅が599px以下のデバイスで、主にポートレートモードの電話
  compact(0.0);

  const WindowSize(this.breakpoint);

  final double breakpoint;
}

extension Responsive on BuildContext {
  T responsive<T>(
    T defaultVal, {
    T? medium,
    T? expanded,
    T? large,
    T? xLarge,
  }) {
    final displayWidth = MediaQuery.of(this).size.width;

    final result = displayWidth >= WindowSize.xLarge.breakpoint
        ? (xLarge ?? large ?? expanded ?? medium ?? defaultVal)
        : displayWidth >= WindowSize.large.breakpoint
            ? (large ?? expanded ?? medium ?? defaultVal)
            : displayWidth >= WindowSize.expanded.breakpoint
                ? (expanded ?? medium ?? defaultVal)
                : displayWidth >= WindowSize.medium.breakpoint
                    ? (medium ?? defaultVal)
                    : defaultVal;

    return result;
  }
}
