# Unistate App

This is a Flutter application demonstrating various state management techniques.

## State Management Implementations

The application includes the following state management implementations:

- CounterBloc
- CounterCubit
- CounterProvider
- CounterGetx

## Getting Started

To run the application, use the following command:

```sh
flutter run
```

## Adding a New State Management Implementation

To add a new state management implementation, follow these steps:

1. Create a new state management class in the `lib/counter/state` directory.
2. Export the new class in `lib/counter/state/counter.dart`.
3. Add an instance of the new class to the `MultiUniState` widget in `lib/main.dart`.

## Screenshots

|   bloc     |   cubit     |   getx     |   provider  |
|------------|-------------|------------|-------------|
![bloc](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/bloc.png)|![cubit](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/cubit.png)|![getx](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/getx.png)|![provider](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/provider.png)|


## CounterGetx

The `CounterGetx` class uses the GetX package for state management. It is implemented as follows:

```dart
import 'package:get/get.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'abstract.dart';

class CounterGetx extends GetxController
    with UnistateGetxMixin<int>
    implements Counter {
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
```

## CounterBloc

The `CounterBloc` class uses the Bloc package for state management. It is implemented as follows:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unistate_adapter/unistate_adapter.dart';

import 'abstract.dart';

class CounterBloc extends Bloc<CounterEvent, int> implements Counter {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) => emit(state + 1));
    on<DecrementEvent>((event, emit) => emit(state - 1));
  }

  @override
  void decrement() {
    add(DecrementEvent());
  }

  @override
  void increment() {
    add(IncrementEvent());
  }
}

abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}
```

Make sure to add `Counter[State]` to the `MultiUniState` widget in `lib/main.dart`:

```dart
// filepath: /home/aye7/Workspace/me/unistate_app/lib/main.dart
void main() {
  runApp(MultiUniState(notifiers: [
    CounterBloc(),
    CounterCubit(),
    CounterProvider(),
    CounterGetx(), // Add the new state management implementation here
  ], child: MyApp()));
}
```

