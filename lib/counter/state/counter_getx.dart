import 'package:get/get.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'abstract.dart';

class CounterGetx extends GetxController
    with UnistateGetxMixin<int>
    implements ICounter {
  CounterGetx() {
    initState(0);
  }

  @override
  void decrement() {
    value--;
  }

  @override
  void increment() {
    value++;
  }
}
