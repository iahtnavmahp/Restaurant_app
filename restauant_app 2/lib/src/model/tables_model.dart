class TablesModel {
  TablesModel({
    this.id,
    this.tableNumber,
    this.seating,
    this.location,
    this.posivition,
    this.status,
  });

  int id;
  String tableNumber;
  int seating;
  String location;
  String posivition;
  bool status;

  factory TablesModel.fromJson(Map<String, dynamic> json) => TablesModel(
    id: json["id"],
    tableNumber: json["tableNumber"],
    seating: json["seating"],
    location: json["location"],
    posivition: json["posivition"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tableNumber": tableNumber,
    "seating": seating,
    "location": location,
    "posivition": posivition,
    "status": status,
  };
}

