import 'package:flutter/material.dart';

enum AppTextSize {
  caption(24),
  standard(16),
  notes(11);

  const AppTextSize(this.fontSize);

  final double fontSize;
}

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.size = AppTextSize.standard,
    this.isBold = false,
    this.textColor,
    this.hasUnderline = false,
    this.height,
  });

  final String text;
  final AppTextSize size;
  final bool isBold;
  final Color? textColor;
  final bool hasUnderline;
  final double? height;

  static const _kCautionColor = Color.fromARGB(0xFF, 0xFF, 0x4A, 0x32);

  factory AppText.bold(String text) {
    return AppText(text, isBold: true);
  }

  factory AppText.caption(String text, {Color? textColor}) {
    return AppText(
      text,
      size: AppTextSize.caption,
      textColor: textColor,
    );
  }

  factory AppText.captionBold(String text) {
    return AppText(
      text,
      size: AppTextSize.caption,
      isBold: true,
    );
  }

  factory AppText.notes(
    String text, {
    Color? textColor,
    double? height,
  }) {
    return AppText(
      text,
      size: AppTextSize.notes,
      textColor: textColor,
      height: height,
    );
  }

  factory AppText.cautionNotes(
    String text, {
    Color? textColor,
    double? height,
  }) {
    return AppText(
      text,
      size: AppTextSize.notes,
      textColor: textColor ?? _kCautionColor,
      height: height,
    );
  }

  factory AppText.notesBold(
    String text, {
    Color? textColor,
    double? height,
  }) {
    return AppText(
      text,
      size: AppTextSize.notes,
      isBold: true,
      textColor: textColor,
      height: height,
    );
  }

  factory AppText.caution(String text) {
    return AppText(
      text,
      textColor: _kCautionColor,
    );
  }

  factory AppText.link(String text) {
    return AppText(
      text,
      textColor: Colors.lightBlue,
      hasUnderline: true,
    );
  }

  factory AppText.linkNote(String text) {
    return AppText(
      text,
      textColor: Colors.lightBlue,
      size: AppTextSize.notes,
      hasUnderline: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: textColor,
        decoration: hasUnderline ? TextDecoration.underline : null,
        decorationColor: textColor,
        height: height,
      ),
    );
  }
}
