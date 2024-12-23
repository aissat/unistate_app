import 'package:unistate_adapter/unistate_adapter.dart';

import 'counter_solid_ctl.dart';
import 'icounter_listenable.dart';

class CounterSolidListenable
    with UnistateListenableMixin<CounterSolidCtl>
    implements ICounterListenable<CounterSolidCtl> {
  final _ctl = CounterSolidCtl();

  @override
  CounterSolidCtl get value => _ctl;

  @override
  void decrement() {
    _ctl.decrement();
    notifyListeners();
  }

  @override
  void increment() {
    _ctl.increment();
    notifyListeners();
  }
}
