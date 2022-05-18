import 'package:flutter/material.dart';
import 'package:is_it_crowded/model/cafeteria_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/cafeteria.dart';

class Prediction extends StatefulWidget {
  final List<Cafeteria> cafeterias;
  const Prediction(this.cafeterias, {Key? key}) : super(key: key);
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  DateTime dateForPrediction = DateTime.now();

  List<Cafeteria> cafeterias = [];
  late Cafeteria selectedCafeteria;

  @override
  void initState() {
    super.initState();
    cafeterias = widget.cafeterias;
    selectedCafeteria = cafeterias.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          title: const Text(
            'Predicción de aforo',
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 22.0),
          ),
        ),
        body: ListView(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                ),
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                height: 700,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const <Widget>[
                              Text("Cafetería",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      fontSize: 22.0)),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                child: DropdownButton<Cafeteria>(
                                  value: selectedCafeteria,
                                  items: cafeterias.map((Cafeteria cafeteria) {
                                    return DropdownMenuItem(
                                      value: cafeteria,
                                      child: Text(cafeteria.name),
                                    );
                                  }).toList(),
                                  onChanged: (Cafeteria? value) {
                                    setState(() {
                                      selectedCafeteria = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Text("Fecha",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                    fontSize: 22.0)),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              child: TextButton(
                                child: Text(dateForPrediction.toString().substring(0, 10),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0)),
                                onPressed: () {
                                  showDatePicker(
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: const ColorScheme.light(
                                            primary: Color(
                                                0xff1c162e), // header background color
                                            onPrimary: Colors
                                                .white, // header text color
                                            onSurface:
                                                Colors.black, // body text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              primary: const Color(
                                                  0xff1c162e), // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    context: context,
                                    initialDate: dateForPrediction,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 7)),
                                  ).then((value) => {
                                        setState(() {
                                          dateForPrediction = value!;
                                        })
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    _buildSplineChart(
                        "Ocupación de mesas",
                        selectedCafeteria.tablesOccupationHistory,
                        Colors.pinkAccent),
                    _buildSplineChart(
                        "Ocupación de sillas",
                        selectedCafeteria.peopleOccupationHistory,
                        Colors.deepPurpleAccent),
                  ],
                )),
          ],
        ));
  }

  Widget _buildSplineChart(
      String title, List<OccupationTimestamp> completeData, Color color) {
    var data = _filterDataForOneDay(completeData);
    return Row(
      children: [
        Column(
          children: <Widget>[
            Row(
              children: [
                CircleAvatar(backgroundColor: color, radius: 5,),
                Text(" " + title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 18.0)),
              ],
            ),
            SizedBox(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    // Renders spline chart
                    SplineSeries<OccupationTimestamp, String>(
                      dataSource: data,
                      xValueMapper: (OccupationTimestamp ot, _) =>
                          _dateTimeToHourAndMinuteString(ot.time, _.isEven),
                      yValueMapper: (OccupationTimestamp ot, _) =>
                          ot.occupation,
                      color: color,
                    )
                  ]),
              width: 360,
              height: 250,
            ),
          ],
        ),
      ],
    );
  }

  List<OccupationTimestamp> _filterDataForOneDay(
      List<OccupationTimestamp> completeData) {
    List<OccupationTimestamp> filtered = [];
    for (OccupationTimestamp ot in completeData) {
      if (ot.time.day == dateForPrediction.day) {
        filtered.add(ot);
      }
    }
    return filtered;
  }

  String _dateTimeToHourAndMinuteString(DateTime dateTime, bool isEven) {
    String hour = dateTime.hour.toString();
    if (hour.length < 2) {
      hour = '0' + hour;
    }
    String minute = dateTime.minute.toString();
    if (minute.length < 2) {
      minute = '0' + minute;
    }
    return "$hour:$minute";
  }
}
