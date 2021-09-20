class AllOrderModel {
  AllOrderModel({
    this.id,
    this.totalPrice,
    this.orderTime,
    this.status,
    this.foods,
    this.customer,
  });

  int id;
  double totalPrice;
  int orderTime;
  bool status;
  List<Food> foods;
  Customer customer;

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
    id: json["id"],
    totalPrice: json["totalPrice"],
    orderTime: json["orderTime"],
    status: json["status"],
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalPrice": totalPrice,
    "orderTime": orderTime,
    "status": status,
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "customer": customer.toJson(),
  };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.phone,
    this.status,
    this.hibernateLazyInitializer,
  });

  int id;
  String name;
  String phone;
  bool status;
  HibernateLazyInitializer hibernateLazyInitializer;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    status: json["status"],
    hibernateLazyInitializer: json["hibernateLazyInitializer"] == null ? null : HibernateLazyInitializer.fromJson(json["hibernateLazyInitializer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone == null ? null : phone,
    "status": status,
    "hibernateLazyInitializer": hibernateLazyInitializer == null ? null : hibernateLazyInitializer.toJson(),
  };
}

class HibernateLazyInitializer {
  HibernateLazyInitializer();

  factory HibernateLazyInitializer.fromJson(Map<String, dynamic> json) => HibernateLazyInitializer(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Food {
  Food({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.status,
    this.category,
  });

  int id;
  String name;
  String description;
  double price;
  String imageUrl;
  bool status;
  Customer category;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    status: json["status"],
    category: Customer.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "status": status,
    "category": category.toJson(),
  };
}
