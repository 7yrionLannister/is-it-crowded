import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/cafeteria.dart';

class LiveOccupation extends StatelessWidget {
  final Cafeteria cafeteria;
  const LiveOccupation(this.cafeteria, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(width: 20, height: 10,),
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
              child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: PhysicalModel(
                            child: Container(),
                            shape: BoxShape.circle,
                            elevation: 10,
                            shadowColor: Colors.black,
                            color: const Color.fromRGBO(230, 230, 230, 1))),
                    CircularChartAnnotation(
                        widget: Text((cafeteria.tablesOccupation / cafeteria.tables * 100).toStringAsFixed(1) + '%',
                            style: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25)))
                  ],
                  borderWidth: 10,
                  series: <CircularSeries>[
                    DoughnutSeries<int, String>(
                        dataSource: [cafeteria.tablesOccupation, cafeteria.tables - cafeteria.tablesOccupation],
                        xValueMapper: (int data, _) => data.toString(),
                        yValueMapper: (int data, _) => data,
                        pointColorMapper: (int data, _) => _.isOdd ? Colors.grey : Colors.blue,
                        // Radius of doughnut
                        radius: '90%'
                    )
                  ]
              ),
              width: 200,
              height: 200,
            ),
          ]),
        ),
        const SizedBox(width: 20, height: 10,),
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
                cafeteria.peopleOccupation.toString() +
                    '/' +
                    cafeteria.maxCapacity.toString(),
                style:
                const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0)),
            SizedBox(
              child: SfCircularChart(
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: PhysicalModel(
                            child: Container(),
                            shape: BoxShape.circle,
                            elevation: 10,
                            shadowColor: Colors.black,
                            color: const Color.fromRGBO(230, 230, 230, 1))),
                    CircularChartAnnotation(
                        widget: Text((cafeteria.peopleOccupation / cafeteria.maxCapacity * 100).toStringAsFixed(1) + '%',
                            style: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25)))
                  ],
                  borderWidth: 10,
                  series: <CircularSeries>[
                    DoughnutSeries<int, String>(
                        dataSource: [cafeteria.peopleOccupation, cafeteria.maxCapacity - cafeteria.peopleOccupation],
                        xValueMapper: (int data, _) => data.toString(),
                        yValueMapper: (int data, _) => data,
                        pointColorMapper: (int data, _) => _.isOdd ? Colors.grey : Colors.blue,
                        // Radius of doughnut
                        radius: '90%'
                    )
                  ]
              ),
              width: 200,
              height: 200,
            ),
          ]),
        ),
      ]),
    );
  }
}
