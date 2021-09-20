class MenuModel {
  MenuModel({
    this.id,
    this.status,
    this.name,
  });

  int id;
  bool status;
  String name;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    id: json["id"],
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "name": name,
  };
}
