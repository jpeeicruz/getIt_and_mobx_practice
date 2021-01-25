import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/getIt/couter-sample'),
              child: Text('GetIt Counter Sample')
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/getIt/crud-sample'),
              child: Text('GetIt Crud Sample')
            )
          ],
        ),
      )
    );
  }
}