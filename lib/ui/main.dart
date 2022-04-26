import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../model/cafeteria.dart';
import 'cafeterias_list.dart';
import 'live_occupation.dart';
import 'prediction.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.removeAfter(initialization); // uncomment this and the "initialization method if initial resource usage requires it"
  runApp(MyApp());
}

/*Future initialization(BuildContext? context) async {
  //await Future.delayed(Duration(seconds: 2));
  // do some tasks that require a lot of resources
}*/

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _cafeterias = [
    Cafeteria("Cafetería central Isabela", 1600, 400,
        lastUpdated: DateTime.now(), image: "assets/images/central.png"),
    Cafeteria("Restaurante Bristo", 1000, 25,
        lastUpdated: DateTime.now(), image: "assets/images/bristo.png"),
    Cafeteria("Restaurante Snack Café", 80, 20,
        lastUpdated: DateTime.now(), image: "assets/images/snack.png"),
  ];

  static Cafeteria? current;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    current = _cafeterias[0];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff1c162e), //0x1c162eff
            foregroundColor: Color(0xffffffff),
            shadowColor: Color(0xff555062),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => CafeteriasListPage(_cafeterias),
          '/liveOccupation': (context) => LiveOccupation(current!),
          '/prediction': (context) => const Prediction(),
        });
  }
}
