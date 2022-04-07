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
          backgroundColor: Color(0xff1c162e), //0x1c162eff
          foregroundColor: Color(0xffffffff),
          shadowColor: Color(0xff555062),
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
    Cafeteria("Cafetería central Isabela", 1600, 400,
        image: "assets/images/central.png"),
    Cafeteria("Restaurante Bristo", 1000, 25,
        image: "assets/images/bristo.png"),
    Cafeteria("Restaurante Snack Café", 80, 20,
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
          onPressed: _navigateToAvailabilityPage,
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
        title: const Text("Cafeterías registradas"),
        actions: [
          IconButton(
            onPressed: _navigateToAvailabilityPage,
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

  // TODO hacer un método parecido a este para la pantalla de forecast y ponerlo en el onPressed del boton con el icono de barchart
  void _navigateToAvailabilityPage() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Ocupación en tiempo real'),
                actions: [
                  IconButton(
                    icon: _notificationsOn
                        ? const Icon(Icons.notifications_on)
                        : const Icon(Icons.notifications_off_outlined),
                    onPressed: () {
                      // FIXME para poder que al modificar el estado desde este "popup" se actualizara
                      // FIXME el icono de notificaciones tuve que retornar un StatefulBuilder, no sé
                      // FIXME si es buena práctica o como hacerlo diferente
                      print(
                          'El cambiar el estado (_notificationOn) no actualiza el icono de notificaciones, supongo que por alguna razón llama al builder de la pantalla de la lista pero no el de esta página que se pusó sobre el stack');
                      setState(() {
                        _notificationsOn = !_notificationsOn;
                      });
                    },
                  ),
                ],
              ),
              body: const Text('Hello worlddddd'),
            );
          },
        );
      }),
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
