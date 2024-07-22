import 'package:flutter/cupertino.dart';

/// Top level app class
class AppClass {
  static final AppClass _singleton = AppClass._internal();

  factory AppClass() {
    return _singleton;
  }

  AppClass._internal();

  ValueNotifier<bool> isShowLoading = ValueNotifier(false);

  /// Show-hide top level loading
  void showLoading(bool value) {
    isShowLoading.value = value;
  }
}
