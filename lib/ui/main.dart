import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'cafeterias_list.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
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
            backgroundColor: Color(0xff1c162e),
            foregroundColor: Color(0xffffffff),
            shadowColor: Color(0xff555062),
          ),
        ),
        home: const CafeteriasListPage(),
    );
  }
}
