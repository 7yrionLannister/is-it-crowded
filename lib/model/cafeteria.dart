class Cafeteria {
  String name;
  DateTime? lastUpdated;
  String image;
  int maxCapacity;
  int tables;
  bool notificationsOn;
  int tablesOccupation;
  int peopleOccupation;
  Map<DateTime, int> tablesOccupationHistory = {};
  Map<DateTime, int> peopleOccupationHistory = {};

  Cafeteria(this.name, this.maxCapacity, this.tables,
      {this.lastUpdated, this.image = "assets/images/appicon.png", this.notificationsOn = false, this.tablesOccupation = 0, this.peopleOccupation = 0});
}
