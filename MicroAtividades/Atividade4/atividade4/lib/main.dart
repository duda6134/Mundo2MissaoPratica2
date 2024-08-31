import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Lista - MaterialApp"),
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
      body: ListView(
              children: [
                ListTile(
                  title: Text('Raio'),
                  subtitle: Text('Isso é um widget'),
                  leading: Icon(Icons.flash_on),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  title: Text('Carinha'),
                  subtitle: Text('Isso também é um widget'),
                  leading: Icon(Icons.mood),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  title: Text('Foguinho'),
                  subtitle: Text('Olha, um widget!'),
                  leading: Icon(Icons.whatshot),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            )
    );
  }
}