import 'package:flutter/material.dart';

void main() => runApp(CachoApp());

class CachoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego del Cacho',
      home: TableroCacho(),
    );
  }
}

class TableroCacho extends StatefulWidget {
  @override
  _TableroCachoState createState() => _TableroCachoState();
}

class _TableroCachoState extends State<TableroCacho> {
  final List<List<String>> categorias = [
    ['Balas', 'Escalera', 'Cuadras'],
    ['Tontos', 'Full', 'Quinas'],
    ['Tricas', 'Poker', 'Senas'],
  ];

  final Map<String, int> incrementos = {
    'Balas': 1,
    'Tontos': 2,
    'Tricas': 3,
    'Cuadras': 4,
    'Quinas': 5,
    'Senas': 6,
    'Escalera': 20,
    'Full': 30,
    'Poker': 40,
  };

  final Map<String, int> maximos = {
    'Balas': 5,
    'Tontos': 10,
    'Tricas': 15,
    'Cuadras': 20,
    'Quinas': 25,
    'Senas': 30,
    'Escalera': 25,
    'Full': 35,
    'Poker': 45,
  };

  final Map<String, int> contadores = {};
  int totalPuntos = 0;

  @override
  void initState() {
    super.initState();
    categorias.expand((fila) => fila).forEach((categoria) {
      contadores[categoria] = 0;
    });
  }

  void incrementar(String categoria) {
    final incremento = incrementos[categoria]!;
    final maximo = maximos[categoria]!;
    setState(() {
      contadores[categoria] =
          (contadores[categoria]! + incremento) > maximo ? 0 : contadores[categoria]! + incremento;
      calcularTotal();
    });
  }

  void calcularTotal() {
    totalPuntos = contadores.values.reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tablero de Cacho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: categorias.map((fila) {
                return TableRow(
                  children: fila.map((categoria) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            categoria,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Puntos: ${contadores[categoria]}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => incrementar(categoria),
                            child: Text('Incrementar'),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total de puntos: $totalPuntos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
