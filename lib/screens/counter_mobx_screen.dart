import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_app/store/counter-store.dart';

class CounterMobxScreen extends StatefulWidget {
  @override
  _CounterMobxScreenState createState () => _CounterMobxScreenState();
}

class _CounterMobxScreenState extends State<CounterMobxScreen> {
  final store = CounterStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mobx Counter'),
      ),
      body: Center(
        child: Observer(
          builder: (_) => Text(
            '${store.counter}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: store.decrement,
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: store.increment,
            child: Icon(Icons.add),
          ),
        ],
      )
    );
  }
}