class BookingModel {
  BookingModel({
    this.id,
    this.checkin,
    this.checkout,
    this.numberInParty,
    this.notes,
    this.status,
    this.customer,
    this.restaurantTables,
    this.isOrder,
  });

  int id;
  String checkin;
  String checkout;
  int numberInParty;
  String notes;
  bool status;
  bool isOrder;
  Customer customer;
  List<RestaurantTable> restaurantTables;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        checkin: json["checkin"],
        checkout: json["checkout"],
        numberInParty: json["numberInParty"],
        notes: json["notes"],
        status: json["status"],
        isOrder: json["isOrder"],
        customer: Customer.fromJson(json["customer"]),
        restaurantTables: List<RestaurantTable>.from(json["restaurantTables"].map((x) => RestaurantTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "checkin": checkin,
        "checkout": checkout,
        "numberInParty": numberInParty,
        "notes": notes,
        "status": status,
        "isOrder": isOrder,
        "customer": customer.toJson(),
        "restaurantTables": List<dynamic>.from(restaurantTables.map((x) => x.toJson())),
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.phone,
    this.status,
    this.numberInParty,
  });

  int id;
  String name;
  String phone;
  int numberInParty;
  bool status;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        status: json["status"],
        numberInParty: json["numberInParty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "status": status,
        "numberInParty": numberInParty,
      };
}

class RestaurantTable {
  RestaurantTable({
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

  factory RestaurantTable.fromJson(Map<String, dynamic> json) => RestaurantTable(
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
