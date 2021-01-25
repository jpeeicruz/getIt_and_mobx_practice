import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/services/CounterService.dart';

GetIt getIt = GetIt.instance;

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    getIt
        .isReady<CounterModel>()
        .then((_) => getIt<CounterModel>().addListener(update));
    super.initState();
  }

  @override
  void dispose() {
    getIt<CounterModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GET IT')),
      body: FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Text('${getIt<CounterModel>().counter}',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w500)));
          } else {
            return Center(
              child: Text('Waiting for initializtion'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getIt<CounterModel>().incrementCounter,
          child: Icon(Icons.add)),
    );
  }
}
