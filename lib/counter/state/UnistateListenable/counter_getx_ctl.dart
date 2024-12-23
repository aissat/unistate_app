import 'package:get/get.dart';

class CounterGetxCtl extends GetxController {
  final _counter = 0.obs;

  CounterGetxCtl();

  int get counter => _counter.value;

  set counter(int value) => _counter.value = value;

  void decrement() {
    _counter.value--;
  }

  void increment() {
    _counter.value++;
  }
}
