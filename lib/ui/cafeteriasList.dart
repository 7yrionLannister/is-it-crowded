import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cafeteria.dart';

class CafeteriasListPage extends StatefulWidget {
  const CafeteriasListPage({Key? key}) : super(key: key);

  @override
  State<CafeteriasListPage> createState() => _CafeteriasListPageState();
}

class _CafeteriasListPageState extends State<CafeteriasListPage> {
  final _cafeterias = [
    Cafeteria("Cafetería central Isabela", 1600, 400,
        lastUpdated: DateTime.now(), image: "assets/images/central.png"),
    Cafeteria("Restaurante Bristo", 1000, 25,
        lastUpdated: DateTime.now(), image: "assets/images/bristo.png"),
    Cafeteria("Restaurante Snack Café", 80, 20,
        lastUpdated: DateTime.now(), image: "assets/images/snack.png"),
  ];

  var _notificationsOn = false;

  @override
  Widget build(BuildContext context) {
    final tiles = _cafeterias.map((cafeteria) {
      return ListTile(
        leading: Image(
          image: AssetImage(cafeteria.image),
        ),
        title: Text(cafeteria.name),
        trailing: IconButton(
          icon: const Icon(Icons.pie_chart_rounded),
          onPressed: () {
            Navigator.pushNamed(context, '/liveOccupation');
          },
          color: Colors.blueGrey,
          tooltip: "Mostrar ocupación",
        ),
        subtitle: Text('Última actualización\n' +
            cafeteria.lastUpdated.toString() +
            '\n\nCapacidad máxima' +
            '\n\t(personas): ' +
            cafeteria.maxCapacity.toString() +
            '\n\t(mesas): ' +
            cafeteria.tables.toString()),
        contentPadding: const EdgeInsets.all(4.0),
      );
    });
    final divided = _cafeterias.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafeterías registradas",
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 22.0)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/prediction');
            },
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: "Predecir ocupación",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: divided,
      ),
    );
  }
}
