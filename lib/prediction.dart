import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prediction extends StatefulWidget{
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {

  DateTime dateForPrediction = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          title: Text(
            'Predicción de aforo',
            style: GoogleFonts.montserrat(
            fontSize: 22
          ),),
        ),
        body: SafeArea(minimum: const EdgeInsets.all(85.0),
          child: ListView(children: <Widget>[
            DecoratedBox(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side:BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
              child: Text(
                "Cafeterias",
                style: GoogleFonts.montserrat(fontSize: 24),
                textAlign: TextAlign.left,
              ),
            ),
          ]),
        )
    );
  }
}

/*DatePickerDialog(
initialDate: DateTime.now(),
firstDate: DateTime.now(),
lastDate: DateTime(2030)),*/