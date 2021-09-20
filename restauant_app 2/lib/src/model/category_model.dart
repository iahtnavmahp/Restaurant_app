class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.status,
  });

  int id;
  String name;
  bool status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };
}
