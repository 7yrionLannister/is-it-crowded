import 'dart:math';

import 'package:flutter/material.dart';
import 'package:is_it_crowded/model/cafeteria_data.dart';
import 'package:is_it_crowded/ui/live_occupation.dart';
import 'package:is_it_crowded/ui/prediction.dart';

import '../model/cafeteria.dart';

class CafeteriasListPage extends StatefulWidget {
  const CafeteriasListPage({Key? key}) : super(key: key);

  @override
  State<CafeteriasListPage> createState() => _CafeteriasListPageState();
}

class _CafeteriasListPageState extends State<CafeteriasListPage> {
  final _cafeterias = [
    Cafeteria("Cafetería central Isabela", 1600, 400,
        tablesOccupation: 150,
        peopleOccupation: 1000,
        lastUpdated: DateTime.now(),
        image: "assets/images/central.png",
    ),
    Cafeteria("Restaurante Bristo", 1000, 300, tablesOccupation: 160, peopleOccupation: 650,
        lastUpdated: DateTime.now(), image: "assets/images/bristo.png"),
    Cafeteria("Restaurante Snack Café", 500, 100, tablesOccupation: 95, peopleOccupation: 460,
        lastUpdated: DateTime.now(), image: "assets/images/snack.png"),
  ];

  @override
  void initState() {
    super.initState();
    for(Cafeteria cafeteria in _cafeterias) {
      cafeteria.peopleOccupationHistory = populateCafeteriaDataWithDummyInformation(cafeteria.maxCapacity);
      cafeteria.tablesOccupationHistory = populateCafeteriaDataWithDummyInformation(cafeteria.tables);
    }
  }

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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Scaffold(
                      backgroundColor: const Color(0xff1c162e),
                      appBar: AppBar(
                        title: const Text(
                          "Ocupación en vivo",
                          style: TextStyle(
                              fontFamily: 'Montserrat', fontSize: 22.0),
                        ),
                        actions: [
                          IconButton(
                            icon: cafeteria.notificationsOn
                                ? const Icon(Icons.notifications_on)
                                : const Icon(Icons.notifications_off_outlined),
                            onPressed: () {
                              setState(() {
                                cafeteria.notificationsOn =
                                    !cafeteria.notificationsOn;
                              });
                            },
                          ),
                        ],
                      ),
                      body: LiveOccupation(cafeteria),
                    );
                  });
                },
              ),
            );
            //Navigator.pushNamed(context, '/liveOccupation');
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
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
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
              //Navigator.pushNamed(context, '/prediction');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                      return Prediction(_cafeterias);
                    }),
                );
            },
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: "Predecir ocupación",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: divided,
      ),
    );
  }

  List<OccupationTimestamp> populateCafeteriaDataWithDummyInformation(int max) {
    Random random = Random();
    DateTime now = DateTime.now();

    List<OccupationTimestamp> dummyTimeStamps = [];
    for(int day = 0; day < 7; day++) {
      for(int hour = 11; hour < 15; hour++) {
        dummyTimeStamps.add(OccupationTimestamp(DateTime(now.year, now.month, now.day + day, hour), random.nextInt(max))); // FIXME random
        dummyTimeStamps.add(OccupationTimestamp(DateTime(now.year, now.month, now.day + day, hour, 30), random.nextInt(max))); // FIXME random
      }
    }
    return dummyTimeStamps;
  }
}
