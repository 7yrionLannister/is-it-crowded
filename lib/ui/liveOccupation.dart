import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveOccupation extends StatefulWidget {
  @override
  _OccupationState createState() => _OccupationState();
}

class _OccupationState extends State<LiveOccupation> {
  var _notificationsOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1c162e),
        appBar: AppBar(
          title: const Text('Ocupación en tiempo real',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 22.0)),
          actions: [
            IconButton(
              icon: _notificationsOn
                  ? const Icon(Icons.notifications_on)
                  : const Icon(Icons.notifications_off_outlined),
              onPressed: () {
                setState(() {
                  _notificationsOn = !_notificationsOn;
                });
              },
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(15.0),
          child: ListView(children: <Widget>[
            DecoratedBox(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white24),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  color: Color(0xff1c162e)),
              child: Column(children: <Widget>[
                const Text(
                  "CAFETERÍA ISABEL", //your text here
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 18.0),
                ),
                Image.asset('assets/images/central.png'),
              ]),
            ),
            DecoratedBox(
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white24),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  color: Colors.white),
              child: Column(children: const <Widget>[
                Text("Ocupación de mesas", //your text here
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 18.0)),
                Text("76/100",
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 16.0)),
              ]),
            ),
          ]),
        ));
  }
}
