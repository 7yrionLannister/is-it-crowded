class Cafeteria {
  String name;
  DateTime? lastUpdated;
  String image;
  int maxCapacity;
  int tables;
  bool notificationsOn;
  int tablesOcupation;
  int peopleOcupation;

  Cafeteria(this.name, this.maxCapacity, this.tables,
      {this.lastUpdated, this.image = "assets/images/appicon.png", this.notificationsOn = false, this.tablesOcupation = 0, this.peopleOcupation = 0});
}
