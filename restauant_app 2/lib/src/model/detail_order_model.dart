class DetailOrderModel {
  DetailOrderModel({
    this.id,
    this.discount,
    this.totalPrice,
    this.orderTime,
    this.status,
    this.foods,
    this.customer,
  });

  int id;
  double discount;
  double totalPrice;
  int orderTime;
  bool status;
  Customer customer;
  List<Food> foods;


  factory DetailOrderModel.fromJson(Map<String, dynamic> json) => DetailOrderModel(
    id: json["id"],
    discount: json["discount"],
    totalPrice: json["totalPrice"],
    orderTime: json["orderTime"],
    status: json["status"],
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "discount": discount,
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
    this.quantity,
    this.price,
    this.imageUrl,
    this.status,
    this.category,
  });

  int id;
  String name;
  String description;
  int quantity;
  double price;
  String imageUrl;
  bool status;
  Customer category;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json["id"],
    name: json["name"],
    description: json["description"] == null ? null : json["description"],
    quantity: json["quantity"],
    price: json["price"].toDouble(),
    imageUrl: json["imageUrl"],
    status: json["status"],
    category: Customer.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description == null ? null : description,
    "quantity": quantity,
    "price": price,
    "imageUrl": imageUrl,
    "status": status,
    "category": category.toJson(),
  };
}
