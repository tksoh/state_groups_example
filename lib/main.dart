import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_groups/state_groups.dart';

// StateGroup<void> exampleStateGroup = StateGroup<void>();

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

class _MyHomePageState extends SyncState2<MyHomePage> {
  int _counter = 0;

  _MyHomePageState() : super();

  // Normally we would use a setState() call here but because we're using state
  // groups we don't have to
  void _incrementCounter() {
    _counter++;

    // exampleStateGroup.notifyAll();
    updateAll<_MyHomePageState>();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateFormat('d/M/y hh:mm:ss a').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const NavigationDrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Updated: $now',
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

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: [
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
                text: 'Update All',
                icon: Icons.people,
                onClicked: () {
                  Navigator.pop(context);
                  forEachState<_MyHomePageState>(
                    (p0) {
                      p0._incrementCounter();
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
