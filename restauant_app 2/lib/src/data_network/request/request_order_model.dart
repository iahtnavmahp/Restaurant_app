class RequestOrderModel {
  RequestOrderModel({
    this.customer,
    this.discount,
    this.foods,
    this.status,
  });

  CustomerOder customer;
  int discount;
  List<CustomerOder> foods;
  bool status;

  factory RequestOrderModel.fromJson(Map<String, dynamic> json) => RequestOrderModel(
        customer: CustomerOder.fromJson(json["customer"]),
        discount: json["discount"],
        foods: List<CustomerOder>.from(json["foods"].map((x) => CustomerOder.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "discount": discount,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "status": status,
      };
}

class CustomerOder {
  CustomerOder({
    this.price,
    this.quantity,
    this.description,
    this.id,
    this.name,
  });

  int id;
  int price;
  int quantity;
  String description;
  String name;

  factory CustomerOder.fromJson(Map<String, dynamic> json) => CustomerOder(
        price: json["price"],
        quantity: json["quantity"],
        description: json["description"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "quantity": quantity,
        "description": description,
        "id": id,
        "name": name,
      };
}
