import 'package:unistate_adapter/unistate_adapter.dart';

import 'counter_getx_ctl.dart';
import 'icounter_listenable.dart';

class CounterGetxListenable
    with UnistateListenableMixin<CounterGetxCtl>
    implements ICounterListenable<CounterGetxCtl> {
  final _ctl = CounterGetxCtl();

  @override
  CounterGetxCtl get value => _ctl;

  @override
  void decrement() {
    value.decrement();
    notifyListeners();
    print('CounterGetx: $value');
  }

  @override
  void increment() {
    value.increment();
    notifyListeners();
    print('CounterGetx: $value');
  }
}
