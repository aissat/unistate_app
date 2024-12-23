import 'package:unistate_adapter/unistate_adapter.dart';

abstract interface class ICounterListenable<T> with UnistateListenableMixin<T> {
  void decrement();
  void increment();
}
