import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:is_it_crowded/main.dart';

class Prediction extends StatefulWidget{
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {

  DateTime dateForPrediction = DateTime.now();

  var cafeterias = ["Isabel", "Central", "Bristo"];
  var selectedvalue = "Bristo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          title: const Text(
            'Predicción de aforo',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 22.0
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 65.0, right: 85.0, top: 50.0, bottom: 10.0),
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Text("Cafeterías",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                fontSize: 22.0)),
                      ],
                    ),
                    Spacer(),
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
                            onChanged: (String? value)
                            {
                              setState(() {
                                selectedvalue = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text("Horario",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: 22.0)),
                    ],
                  ),
                  Spacer(),
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
                          onChanged: (String? value)
                          {
                            setState(() {
                              selectedvalue = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ),
    );
  }
}