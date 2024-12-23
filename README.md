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

| bloc                                                                                   | cubit                                                                                    | getx                                                                                   | provider                                                                                       |
| -------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| ![bloc](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/bloc.png) | ![cubit](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/cubit.png) | ![getx](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/getx.png) | ![provider](https://raw.githubusercontent.com/aissat/unistate_app/main/screenshots/provider.png) |

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

## UnistateListenableMixin

`UnistateListenableMixin` is a mixin that provides a way to listen to state changes and notify listeners. It is used in conjunction with state management controllers to provide a reactive programming model.

### Why Use UnistateListenableMixin?

The `UnistateListenableMixin` simplifies the process of creating reactive state management solutions by providing a consistent way to notify listeners about state changes. This mixin abstracts away the boilerplate code required to manage listeners, making your code cleaner and easier to maintain.

### Benefits

- **Consistency**: Provides a consistent way to manage state changes across different state management solutions.
- **Simplicity**: Reduces boilerplate code by handling listener notifications automatically.
- **Reusability**: Can be reused across different state management controllers, promoting code reuse.
- **Maintainability**: Makes the codebase easier to maintain by centralizing the listener notification logic.
- **Flexibility**: Supports any state management solution, making it easy to integrate with various state management libraries.

### Usage

To use `UnistateListenableMixin`, you need to create a class that mixes it in and implements the `ICounterListenable` interface. Here is an example:

```dart
import 'package:unistate_adapter/unistate_adapter.dart';

abstract interface class ICounterListenable<T> with UnistateListenableMixin<T> {
  void decrement();
  void increment();
}
```

### Example

Here is an example of how to use `UnistateListenableMixin` with a GetX controller:

```dart
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
```

And here is an example with a Solidart controller:

```dart
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
```

In both examples, the `notifyListeners` method is called after the state is modified to notify any listeners about the change.
