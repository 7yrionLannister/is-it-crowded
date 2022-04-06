import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.removeAfter(initialization); // uncomment this and the "initialization method if initial resource usage requires it"
  runApp(const MyApp());
}

/*Future initialization(BuildContext? context) async {
  //await Future.delayed(Duration(seconds: 2));
  // do some tasks that require a lot of resources
}*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafeterías registradas',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0x1c162eff),
          foregroundColor: Color(0xffffffff),
          shadowColor: Color(0x555062ff),
        ),
      ),
      home: const CafeteriasListPage(),
    );
  }
}

class CafeteriasListPage extends StatefulWidget {
  const CafeteriasListPage({Key? key}) : super(key: key);

  @override
  State<CafeteriasListPage> createState() => _CafeteriasListPageState();
}

class _CafeteriasListPageState extends State<CafeteriasListPage> {
  final _cafeterias = [
    Cafeteria("Cafetería central Isabela", 1600, 400),
    Cafeteria("Restaurante Bristo", 1000, 25),
    Cafeteria("Restaurante Snack Café", 80, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafeterías registradas"),
        actions: [
          IconButton(
              onPressed: navigateToForecastPage,
              icon: const Icon(Icons.bar_chart_rounded),
              tooltip: "Predecir ocupación",
          ),
        ],
      ),
      body: const Text("Hello world") // TODO configurar la lista,
    );
  }

  void navigateToForecastPage() {}
}

class Cafeteria {
  String name;
  DateTime? lastUpdated;
  int maxCapacity;
  int tables;

  Cafeteria(this.name, this.maxCapacity, this.tables) {}
}
