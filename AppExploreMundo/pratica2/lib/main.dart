import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Viajando'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'sobre'),
                Tab(text: 'destinos'),
                Tab(text: 'pacotes'),
                Tab(text: 'contato'),
              ],
            ),
          ),
          body: Container(
            child:TabBarView(
              children: [
                Sobre(),
                Lugares(),
                Pacotes(),
                Contato(),
              ],
            ),
          )
        ),
      ),
    );
  }
}

class Sobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Destino>>(
      future: _loadDestinos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        } else {
          List<Destino> destinos = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: _buildBanner(destinos),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0), 
                    child: Text(
                      'Bem-vindo ao aplicativo Explore o mundo. Aqui você poderá encontrar lugares incríveis para trilhas, camping, escalada e várias aventuras. Nossa agência foi inaugurada em 1998, e desde então fazemos questão de não apenas encontrar os melhores destinos, como nossos agente o visitam pessoalmente, para avaliar os passeios e achar os melhores lugares e pessoas para guiar sua jornada.',
                      softWrap: true,
                    ),
                  ),
                )
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildBanner(List<Destino> destinos) {
  return Container(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: destinos.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalhesDestino(destino: destinos[index]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              child: Image.asset(
                destinos[index].imagem,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}


  Future<List<Destino>> _loadDestinos() async {
    final jsonString = await rootBundle.rootBundle.loadString('lib/destinos/destinos.json');
    final List<dynamic> jsonResponse = json.decode(jsonString)['destinos'];
    return jsonResponse.map((data) => Destino.fromJson(data)).toList();
  }
}

class Lugares extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Destino>>(
      future: _loadDestinos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        } else {
          List<Destino> destinos = snapshot.data!;
          return ListView.builder(
            itemCount: destinos.length,
            itemBuilder: (context, index) {
              return _buildDestino(destinos[index], context);
            },
          );
        }
      },
    );
  }

  Future<List<Destino>> _loadDestinos() async {
    final jsonString = await rootBundle.rootBundle.loadString('lib/destinos/destinos.json');
    final List<dynamic> jsonResponse = json.decode(jsonString)['destinos'];
    return jsonResponse.map((data) => Destino.fromJson(data)).toList();
  }

  Widget _buildDestino(Destino destino, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(
          destino.imagem,
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(destino.nome),
        subtitle: Text(destino.local),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalhesDestino(destino: destino),
            ),
          );
        },
      ),
    );
  }
}

class DetalhesDestino extends StatelessWidget {
  final Destino destino;

  DetalhesDestino({required this.destino});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destino.nome),
      ),
      body: ListView(
        children: [
          Image.asset(
            destino.imagem,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          destino.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        destino.local,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
                const Text('41'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(Colors.blue, Icons.call, 'CALL'),
              _buildButtonColumn(Colors.blue, Icons.near_me, 'ROUTE'),
              _buildButtonColumn(Colors.blue, Icons.share, 'SHARE'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              destino.descricao,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class Destino {
  final int id;
  final String nome;
  final String local;
  final String descricao;
  final String imagem;

  Destino({
    required this.id,
    required this.nome,
    required this.local,
    required this.descricao,
    required this.imagem,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    return Destino(
      id: json['id'],
      nome: json['nome'],
      local: json['local'],
      descricao: json['descrição'],
      imagem: json['imagem'],
    );
  }
}

class Pacotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Em breve', style: TextStyle(fontSize: 20),),
    );
  }
}

class Contato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter, 
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text.rich(
              TextSpan(
                text: 'Estamos em vários lugares pelo Brasil:',
                children: [
                  TextSpan(text: '\nAv. Rosinha 187 - SP;'),
                  TextSpan(text: '\nRua Jacaré 1933 - MG;'),
                  TextSpan(text: '\nAv. Tridente Santa saída 9 - GO;'),
                  TextSpan(text: '\nRua Palhinha 543, ap 45 - MS;'),
                  TextSpan(text: '\n\nTelefones: (21) 9867 - 7845, (31) 4705-1232;'),
                  TextSpan(text: '\n\nWhatZap: (21) 96534-9843'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
