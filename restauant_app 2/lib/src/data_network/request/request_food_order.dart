class RequestAddFood {
  RequestAddFood({
    this.orderId,
    this.foodId,
    this.quantity,
    this.price,
  });

  int orderId;
  int foodId;
  int quantity;
  double price;

  factory RequestAddFood.fromJson(Map<String, dynamic> json) => RequestAddFood(
    orderId: json["orderId"],
    foodId: json["foodId"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "foodId": foodId,
    "quantity": quantity,
    "price": price,
  };
}

class RequestEditOrder {
  RequestEditOrder({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.description,
    this.category_id,
    this.status,
  });

  int id;
  String name;
  String imageUrl;
  String description;
  double price;
  int category_id;
  bool status;

  factory RequestEditOrder.fromJson(Map<String, dynamic> json) => RequestEditOrder(
    id: json["id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    price: json["price"],
    description: json["description"],
    category_id: json["category_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageUrl": imageUrl,
    "price": price,
    "description": description,
    "category_id": category_id,
    "status": status,
  };
}

