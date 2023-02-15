import 'package:flutter/foundation.dart';

extension StreamExtensions<T> on Stream<T> {
  ValueListenable<T> toValueNotifier(
    T initialValue, {
    bool Function(T previous, T current)? notifyWhen,
  }) {
    final notifier = ValueNotifier<T>(initialValue);
    listen((value) {
      if (notifyWhen == null || notifyWhen(notifier.value, value)) {
        notifier.value = value;
      }
    });
    return notifier;
  }

  Listenable toListenable() {
    final notifier = ChangeNotifier();
    listen((_) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      notifier.notifyListeners();
    });
    return notifier;
  }
}
