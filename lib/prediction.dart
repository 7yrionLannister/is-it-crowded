import 'package:flutter/material.dart';

class Prediction extends StatefulWidget{
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text('Prediction')),
    );
  }
}