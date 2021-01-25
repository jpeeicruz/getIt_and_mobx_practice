

import 'package:flutter/material.dart';

import 'package:test_app/main.dart';

abstract class CounterModel extends ChangeNotifier {
  void incrementCounter();

  int get counter;
}

class CounterImplementation extends CounterModel {
  int _counter = 0;

  CounterImplementation() {
    Future.delayed(Duration(seconds: 3)).then((_) => getIt.signalReady(this));
  }

  @override
  // TODO: implement counter
  int get counter => _counter;

  @override
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

}

