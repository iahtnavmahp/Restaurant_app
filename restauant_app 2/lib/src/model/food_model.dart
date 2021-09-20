class FoodModel {
  FoodModel({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.quantity,
    this.description,
    this.status,
  });

  int id;
  String name;
  String imageUrl;
  String description;
  double price;
  bool status;
  int quantity;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    id: json["id"] == null ? json["foodId"] : json["id"],
    name: json["name"] == null ? json["foodName"] : json["name"],
    imageUrl: json["imageUrl"],
    price: json["price"],
    quantity: json["quantity"],
    status: json["status"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageUrl": imageUrl,
    "price": price,
    "quantity": quantity,
    "status": status,
    "description": description,
  };
}
