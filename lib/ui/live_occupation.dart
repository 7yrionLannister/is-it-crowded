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
            Image.asset(cafeteria.image, scale: 1.2,),
          ]),
        ),
        _buildSpacer(),
        DecoratedBox(
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.white),
          child: _buildPieChart("Ocupación de mesas", cafeteria.tables, cafeteria.tablesOccupation, Colors.blue),
        ),
        _buildSpacer(),
        DecoratedBox(
          decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white24),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              color: Colors.white),
          child: _buildPieChart("Ocupación de sillas", cafeteria.maxCapacity, cafeteria.peopleOccupation, Colors.redAccent),
        ),
      ]),
    );
  }

  Widget _buildPieChart(String title, int max, int current, Color color) {
    const titleTextStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
        fontSize: 18.0);
    return Column(children: <Widget>[
      _buildSpacer(),
      Text(title,
          style: titleTextStyle,
      ),
      Text(
          current.toString() +
              '/' +
              max.toString(),
          style: const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0),
      ),
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
                  widget: Text((current / max * 100).toStringAsFixed(1) + '%',
                      style: titleTextStyle))
            ],
            borderWidth: 10,
            series: <CircularSeries>[
              DoughnutSeries<int, String>(
                dataSource: [current, max - current],
                xValueMapper: (int data, _) => data.toString(),
                yValueMapper: (int data, _) => data,
                pointColorMapper: (int data, _) => _.isOdd ? Colors.grey : color,
                // Radius of doughnut
                radius: '80%',
                cornerStyle: CornerStyle.bothCurve,
                innerRadius: '80%',
              )
            ]
        ),
        width: 200,
        height: 170,
      ),
    ]);
  }

  Widget _buildSpacer() {
    return const SizedBox(width: 20, height: 10,);
  }
}
