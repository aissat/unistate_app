import 'package:flutter/foundation.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'abstract.dart';

class CounterProvider extends ChangeNotifier
    with UnistateNotifierMixin<int>
    implements ICounter {
  CounterProvider() : super();

  @override
  int get initialValue => 0;

  @override
  void decrement() {
    value--;
    // notifyListeners();
  }

  @override
  void increment() {
    value++;
    // notifyListeners();
  }
}
