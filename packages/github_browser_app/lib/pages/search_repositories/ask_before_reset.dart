import 'package:flutter/material.dart';

abstract interface class AskIfReset {
  Future<bool?> askIfReset(BuildContext context, String keyword);
}
