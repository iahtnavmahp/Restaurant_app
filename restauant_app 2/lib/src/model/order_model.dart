import 'detail_order_model.dart';

class OrderModel {
  OrderModel({
    this.id,
    this.totalPrice,
    this.orderTime,
    this.status,
    this.customer,
  });

  int id;
  double totalPrice;
  int orderTime;
  bool status;
  Customer customer;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        totalPrice: json["totalPrice"],
        orderTime: json["orderTime"],
        status: json["status"],
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalPrice": totalPrice,
        "orderTime": orderTime,
        "status": status,
        "customer": customer.toJson(),
      };
}
