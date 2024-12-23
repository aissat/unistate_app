import 'package:get/get.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'counter_interface.dart';

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
