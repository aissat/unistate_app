import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'counter_interface.dart';

class CounterBloc extends Bloc<CounterEvent, int>
    with UnistateBlocMixin<CounterEvent, int>
    implements ICounter {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }

  @override
  void decrement() {
    add(Decrement());
  }

  @override
  void increment() {
    add(Increment());
  }
}

sealed class CounterEvent {}

class Decrement extends CounterEvent {}

class Increment extends CounterEvent {}
