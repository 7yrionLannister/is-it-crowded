import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../model/cafeteria.dart';

class LiveOccupation extends StatelessWidget {
  final Cafeteria cafeteria;
  const LiveOccupation(this.cafeteria, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<dynamic, num>> tablesOccupationList = [
      charts.Series<int, int>(
        id: "Ocupación de mesas",
        domainFn: (int i, _) => i,
        measureFn: (int j, _) => j,
        data: [
          cafeteria.tablesOccupation,
          cafeteria.tables - cafeteria.tablesOccupation
        ],
      ),
    ];
    final List<charts.Series<dynamic, num>> peopleOccupationList = [
      charts.Series<int, int>(
        id: "Ocupación de sillas",
        domainFn: (int i, _) => i,
        measureFn: (int j, _) => j,
        data: [
          cafeteria.peopleOccupation,
          cafeteria.maxCapacity - cafeteria.peopleOccupation
        ],
      ),
    ];
    return SafeArea(
      minimum: const EdgeInsets.all(15.0),
      child: ListView(children: <Widget>[
        DecoratedBox(
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Color(0xff1c162e)),
          child: Column(children: <Widget>[
            Text(
              cafeteria.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 18.0),
            ),
            Image.asset(cafeteria.image),
          ]),
        ),
        DecoratedBox(
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.white),
          child: Column(children: <Widget>[
            const Text("Ocupación de mesas",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 18.0)),
            Text(
                cafeteria.tablesOccupation.toString() +
                    '/' +
                    cafeteria.tables.toString(),
                style:
                    const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0)),
            SizedBox(
              child: charts.PieChart(
                tablesOccupationList,
                animate: true,
              ),
              width: 200,
              height: 200,
            ),
          ]),
        ),
        DecoratedBox(
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.white),
          child: Column(children: <Widget>[
            const Text("Ocupación de sillas",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 18.0)),
            Text(
                cafeteria.maxCapacity.toString() +
                    '/' +
                    cafeteria.peopleOccupation.toString(),
                style:
                    const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0)),
            SizedBox(
              child: charts.PieChart(peopleOccupationList, animate: true),
              width: 200,
              height: 200,
            ),
          ]),
        ),
      ]),
    );
  }
}
