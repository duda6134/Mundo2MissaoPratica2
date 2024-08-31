import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Stack - MaterialApp"),
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
      body: Stack(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  color: Colors.green,
                ),
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.black,
                ),
                Container(
                  width: 150,
                  height: 150,
                  color: Colors.orange,
                )
              ],
            )
    );
  }
}