import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Flutter - MaterialApp"),
    )
  );
}

class StatelessWidgetExemplo extends
StatelessWidget {

  final String _appBarTitle;
  StatelessWidgetExemplo(this._appBarTitle) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Center(
        child: Text('Frase Filosófica Aqui'),
      ),
    );
  }
}