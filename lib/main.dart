import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'liveOccupation.dart';
import 'prediction.dart';


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
          '/': (context) => const CafeteriasListPage(),
          '/liveOccupation': (context) => LiveOccupation(),
          '/prediction': (context) => Prediction(),
        }
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
    Cafeteria( "Cafetería central Isabela", 1600, 400,lastUpdated: DateTime.now(),
        image: "assets/images/central.png"),
    Cafeteria("Restaurante Bristo", 1000, 25, lastUpdated: DateTime.now(),
        image: "assets/images/bristo.png"),
    Cafeteria("Restaurante Snack Café", 80, 20, lastUpdated: DateTime.now(),
        image: "assets/images/snack.png"),
  ];

  var _notificationsOn = false;

  @override
  Widget build(BuildContext context) {
    final tiles = _cafeterias.map((cafeteria) {
      return ListTile(
        leading: Image(
          image: AssetImage(cafeteria.image),
        ),
        title: Text(cafeteria.name),
        trailing: IconButton(
          icon: const Icon(Icons.pie_chart_rounded),
          onPressed: (){
            Navigator.pushNamed(context, '/liveOccupation');
          },
          color: Colors.blueGrey,
          tooltip: "Mostrar ocupación",
        ),
        subtitle: Text('Última actualización\n' +
            cafeteria.lastUpdated.toString() +
            '\n\nCapacidad máxima' +
            '\n\t(personas): ' +
            cafeteria.maxCapacity.toString() +
            '\n\t(mesas): ' +
            cafeteria.tables.toString()),
        contentPadding: const EdgeInsets.all(4.0),
      );
    });
    final divided = _cafeterias.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <Widget>[];
    return Scaffold(
      appBar: AppBar(
        title: Text("Cafeterías registradas",
        style: GoogleFonts.montserrat(fontSize: 22),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/prediction');
            },
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: "Predecir ocupación",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: divided,
      ),
    );
  }
}

class Cafeteria {
  String name;
  DateTime? lastUpdated;
  String image;
  int maxCapacity;
  int tables;

  Cafeteria(this.name, this.maxCapacity, this.tables,
      {this.lastUpdated, this.image = "assets/images/appicon.png"});
}
