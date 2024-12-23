import 'package:flutter/material.dart';
import 'package:unistate_app/counter/state/counter.dart';
import 'package:unistate_app/counter/view/counter_page.dart';
import 'package:unistate_provider/unistate_provider.dart';

void main() {
  runApp(MultiUniState(notifiers: [
    CounterBloc(),
    CounterCubit(),
    CounterProvider(),
    CounterGetx(),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}
