import 'package:solidart/solidart.dart';

class CounterSolidCtl {
  final _counter = Signal(0);

  int get counter => _counter.value;

  set counter(int value) {
    _counter.value = value;
  }

  void decrement() {
    _counter.value--;
  }

  void increment() {
    _counter.value++;
  }
}
