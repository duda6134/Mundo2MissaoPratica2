import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Ìcones - MaterialApp"),
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
      body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[Icon(Icons.call), Text('Ligar')],
                ),
                Column(
                  children: <Widget>[Icon(Icons.directions), Text('Rota')],
                ),
                Column(
                  children: <Widget>[Icon(Icons.share), Text('Compartilhar')],
                )
              ],
            )
    );
  }
}