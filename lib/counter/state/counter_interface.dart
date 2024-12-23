import 'package:flutter/foundation.dart';

abstract interface class ICounter extends ValueListenable<int> {
  void decrement();
  void increment();
}
