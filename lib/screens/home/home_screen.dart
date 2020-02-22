import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  void handleGoToCalculator(context) {
    Navigator.of(context).pushNamed("/calculator");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () => handleGoToCalculator(context),
            child: Text("Calculator"),
          ),
        ],
      ),
    );
  }
}
