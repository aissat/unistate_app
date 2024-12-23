import 'package:flutter/material.dart';
import 'package:unistate_app/counter/state/counter.dart';
import 'package:unistate_provider/unistate_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterDisplay extends StatelessWidget {
  final Counter counter;
  const _CounterDisplay({required this.counter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Counter",
          style: TextStyle(fontSize: 24),
        ),
        Text(
          "${counter.value}",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                counter.increment();
              },
              child: Text("Increment (+)"),
            ),
            ElevatedButton(
              onPressed: () {
                counter.decrement();
              },
              child: Text("decrement (-)"),
            ),
          ],
        ),
      ],
    );
  }
}

class _CounterPageState extends State<CounterPage> {
  late Counter _selectedStateManagement;

  @override
  Widget build(BuildContext context) {
    var counter = _handleListenableChange(_selectedStateManagement, context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Column(
        // spacing: 25,
        children: [
          SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio<Counter>(
                    value: context.watch<CounterCubit>()!,
                    groupValue: _selectedStateManagement,
                    onChanged: _handleRadioValueChange,
                  ),
                  const Text('Cubit '),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<Counter>(
                    value: context.watch<CounterBloc>()!,
                    groupValue: _selectedStateManagement,
                    onChanged: _handleRadioValueChange,
                  ),
                  const Text('Bloc'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<Counter>(
                    value: context.watch<CounterGetx>()!,
                    groupValue: _selectedStateManagement,
                    onChanged: _handleRadioValueChange,
                  ),
                  const Text('GetX'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio<Counter>(
                    value: context.watch<CounterProvider>()!,
                    groupValue: _selectedStateManagement,
                    onChanged: _handleRadioValueChange,
                  ),
                  const Text('Provider'),
                ],
              ),
            ],
          ),
          Spacer(),
          _CounterDisplay(counter: counter!),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  @override
  void initState() {
    _selectedStateManagement = context.read<CounterBloc>()!;
    super.initState();
  }

  Counter? _handleListenableChange(Counter? value, BuildContext c) {
    return switch (value) {
      CounterBloc _ => c.watch<CounterBloc>()!,
      CounterCubit _ => c.watch<CounterCubit>()!,
      CounterProvider _ => c.watch<CounterProvider>()!,
      CounterGetx _ => c.watch<CounterGetx>()!,
      _ => c.watch<CounterProvider>()
    };
  }

  void _handleRadioValueChange(Counter? value) {
    setState(() {
      _selectedStateManagement = value!;
    });
  }
}
