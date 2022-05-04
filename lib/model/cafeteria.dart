import 'package:is_it_crowded/model/cafeteriaData.dart';

class Cafeteria {
  String name;
  DateTime? lastUpdated;
  String image;
  int maxCapacity;
  int tables;
  bool notificationsOn;
  int tablesOccupation;
  int peopleOccupation;
  List<CafeteriaData> tablesOccupationHistory = [];
  List<CafeteriaData> peopleOccupationHistory = [];

  Cafeteria(this.name, this.maxCapacity, this.tables,
      {this.lastUpdated, this.image = "assets/images/appicon.png", this.notificationsOn = false, this.tablesOccupation = 0, this.peopleOccupation = 0});
}
