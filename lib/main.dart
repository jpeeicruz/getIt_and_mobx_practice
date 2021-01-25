import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/screens/counter_screen.dart';
import 'package:test_app/screens/home_screen.dart';
import 'package:test_app/services/CounterService.dart';
import 'package:test_app/services/LoginService.dart';
import 'package:test_app/services/UserService.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton(UserService());
  getIt.registerSingleton<CounterModel>(CounterImplementation(),
      signalsReady: true);
  getIt.registerFactory<LoginService>(() => LoginService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetIt and MOBX practice',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomeScreen());
          case '/getIt/couter-sample':
            return MaterialPageRoute(builder: (_) => CounterScreen());
        }
      },
    );
  }
}


