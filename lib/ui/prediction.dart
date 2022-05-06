import 'package:flutter/material.dart';
import 'package:is_it_crowded/model/cafeteriaData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class Prediction extends StatefulWidget {
  const Prediction({Key? key}) : super(key: key);
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  DateTime dateForPrediction = DateTime.now();

  var cafeterias = ["Cafetería central Isabela", "Restaurante Snack Café", "Restaurante Bristo"];
  var selectedvalue = "Restaurante Bristo";

  List<CafeteriaData> tablesOccupationData = [
    CafeteriaData(10, 20),
    CafeteriaData(20, 40),
    CafeteriaData(30, 10),
    CafeteriaData(40, 30),
  ];
  List<CafeteriaData> peopleOccupationData = [];

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
                            child: DropdownButton(
                              value: selectedvalue,
                              items: cafeterias.map((String cafeterias) {
                                return DropdownMenuItem(
                                  value: cafeterias,
                                  child: Text(cafeterias),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  selectedvalue = value!;
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
                          child:
                          TextButton(child: const
                          Text("Elegir",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0)
                          ),
                            onPressed: () {
                              showDatePicker(
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Color(0xff1c162e), // header background color
                                          onPrimary: Colors.white, // header text color
                                          onSurface: Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: const Color(0xff1c162e), // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime(2023),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030)
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        const Text("Ocupación de mesas",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 18.0)
                        ),
                        SizedBox(
                          child: SfCartesianChart(
                              series: <ChartSeries>[
                                // Renders spline chart
                                SplineSeries<CafeteriaData, int>(
                                  dataSource: tablesOccupationData,
                                  xValueMapper: (CafeteriaData data, _) => data.time,
                                  yValueMapper: (CafeteriaData data, _) => data.occupation,
                                )
                              ]
                          ),
                          width: 300,
                          height: 250,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        const Text("Ocupación de sillas",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 18.0)
                        ),
                        SizedBox(
                          child: SfCartesianChart(
                              series: <ChartSeries>[
                                // Renders spline chart
                                SplineSeries<CafeteriaData, int>(
                                  dataSource: peopleOccupationData,
                                  xValueMapper: (CafeteriaData data, _) => data.time,
                                  yValueMapper: (CafeteriaData data, _) => data.occupation,
                                )
                              ]
                          ),
                          width: 300,
                          height: 250,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
        ),
        ],
      )
    );
  }
}
