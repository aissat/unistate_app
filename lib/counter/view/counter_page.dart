import 'package:flutter/material.dart';
import 'package:unistate_app/counter/state/counter.dart';
import 'package:unistate_provider/unistate_provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterDisplay extends StatelessWidget {
  final ICounter counter;
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
        _buildCounterButtons(counter),
      ],
    );
  }

  Widget _buildCounterButtons(ICounter counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: counter.increment,
          child: Text("Increment (+)"),
        ),
        ElevatedButton(
          onPressed: counter.decrement,
          child: Text("decrement (-)"),
        ),
      ],
    );
  }
}

class _CounterDisplayByListenable extends StatelessWidget {
  final ICounterListenable counter;

  const _CounterDisplayByListenable({required this.counter});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Counter",
          style: TextStyle(fontSize: 24),
        ),
        Text(
          "${counter.value.counter}",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 35),
        _buildCounterButtons(counter),
      ],
    );
  }

  Widget _buildCounterButtons(ICounterListenable counter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: counter.increment,
          child: Text("Increment (+)"),
        ),
        ElevatedButton(
          onPressed: counter.decrement,
          child: Text("decrement (-)"),
        ),
      ],
    );
  }
}

class _CounterPageState extends State<CounterPage> {
  late ICounter _selectedStateManagement;
  late ICounterListenable _selectedStateManagementListenable;

  @override
  Widget build(BuildContext context) {
    var counter = _handleListenableChange(_selectedStateManagement, context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Column(
        children: [
          SizedBox(height: 35),
          _buildStateManagementOptions(context),
          Spacer(),
          _CounterDisplay(counter: counter!),
          Spacer(),
          Text(
            'Counter by Listenable',
            style: TextStyle(fontSize: 24),
          ),
          Spacer(),
          _buildListenableOptions(context),
          Spacer(),
          _CounterDisplayByListenable(
              counter: _selectedStateManagementListenable),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  @override
  void initState() {
    _selectedStateManagement = context.read<CounterBloc>()!;
    _selectedStateManagementListenable =
        context.read<CounterSolidListenable>()!;
    super.initState();
  }

  Widget _buildListenableOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRadioOption<ICounterListenable>(
          context: context,
          value: context.watch<CounterSolidListenable>()!,
          groupValue: _selectedStateManagementListenable,
          label: 'Getx',
          onChanged: _handleRadioValueChangeListen,
        ),
        _buildRadioOption<ICounterListenable>(
          context: context,
          value: context.watch<CounterGetxListenable>()!,
          groupValue: _selectedStateManagementListenable,
          label: 'Solidart',
          onChanged: _handleRadioValueChangeListen,
        ),
      ],
    );
  }

  Widget _buildRadioOption<T>({
    required BuildContext context,
    required T value,
    required T groupValue,
    required String label,
    required void Function(T?) onChanged,
  }) {
    return Row(
      children: <Widget>[
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildStateManagementOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildRadioOption<ICounter>(
          context: context,
          value: context.watch<CounterCubit>()!,
          groupValue: _selectedStateManagement,
          label: 'Cubit',
          onChanged: _handleRadioValueChange,
        ),
        _buildRadioOption<ICounter>(
          context: context,
          value: context.watch<CounterBloc>()!,
          groupValue: _selectedStateManagement,
          label: 'Bloc',
          onChanged: _handleRadioValueChange,
        ),
        _buildRadioOption<ICounter>(
          context: context,
          value: context.watch<CounterGetx>()!,
          groupValue: _selectedStateManagement,
          label: 'GetX',
          onChanged: _handleRadioValueChange,
        ),
        _buildRadioOption<ICounter>(
          context: context,
          value: context.watch<CounterProvider>()!,
          groupValue: _selectedStateManagement,
          label: 'Provider',
          onChanged: _handleRadioValueChange,
        ),
      ],
    );
  }

  ICounter? _handleListenableChange(ICounter? value, BuildContext c) {
    return switch (value) {
      CounterBloc _ => c.watch<CounterBloc>()!,
      CounterCubit _ => c.watch<CounterCubit>()!,
      CounterProvider _ => c.watch<CounterProvider>()!,
      CounterGetx _ => c.watch<CounterGetx>()!,
      _ => c.watch<CounterProvider>()
    };
  }

  void _handleRadioValueChange(ICounter? value) {
    setState(() {
      _selectedStateManagement = value!;
    });
  }

  void _handleRadioValueChangeListen(ICounterListenable? value) {
    setState(() {
      _selectedStateManagementListenable = value!;
    });
  }
}
