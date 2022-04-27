import 'package:flutter/material.dart';

import '../model/cafeteria.dart';

Cafeteria currentCafeteria = Cafeteria("name", 999, 999);

class LiveOccupation extends StatefulWidget {
  LiveOccupation(Cafeteria cafeteria, {Key? key}) : super(key: key) {
    currentCafeteria = cafeteria;
  }

  @override
  _OccupationState createState() => _OccupationState();
}

class _OccupationState extends State<LiveOccupation> {
  var _notificationsOn = false;

  @override
  void initState() {
    super.initState();
    _notificationsOn = currentCafeteria.notificationsOn;
  }

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
              currentCafeteria.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 18.0),
            ),
            Image.asset(currentCafeteria.image),
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
            Text(currentCafeteria.tablesOcupation.toString() + '/' + currentCafeteria.tables.toString(),
                style: const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0)),
          ]),
        ),
      ]),
    );
  }
}
