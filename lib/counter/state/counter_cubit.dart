import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'abstract.dart';

class CounterCubit extends Cubit<int>
    with UnistateCubitMixin<int>
    implements Counter {
  CounterCubit() : super(0);

  @override
  void decrement() => emit(state - 1);
  @override
  void increment() => emit(state + 1);
}
