import 'package:flutter/material.dart';
import 'package:state_groups/state_groups.dart';

StateGroup<void> exampleStateGroup = StateGroup<void>();
StateGroup<void> exampleStateGroup2 = StateGroup<void>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int stateCount = 0;

  _MyHomePageState() : super();

  // Normally we would use a setState() call here but because we're using state
  // groups we don't have to
  void _incrementCounter() {
    _counter++;
    stateCount++;

    if (_counter % 5 == 0) {
      exampleStateGroup.notifyAll();
    } else {
      exampleStateGroup2.notifyAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            SyncStateBuilder(
              stateGroup: exampleStateGroup,
              builder: (context) {
                return Text('State count: $_counter');
              },
            ),
            SyncStateBuilder(
              stateGroup: exampleStateGroup2,
              builder: (context) {
                return Text('State count: $stateCount');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
