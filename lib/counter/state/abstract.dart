import 'package:flutter/foundation.dart';

abstract class Counter implements ValueListenable<int> {
  void decrement();
  void increment();
}
