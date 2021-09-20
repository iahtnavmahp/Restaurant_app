class PaymentModel {
  PaymentModel({
    this.id,
    this.title,
    this.methodType,
    this.accountName,
    this.bankName,
    this.accountNumber,
  });

  int id;
  String title;
  int methodType;
  String accountName;
  String bankName;
  String accountNumber;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json["id"],
    title: json["title"],
    methodType: json["methodType"],
    accountName: json["accountName"],
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "methodType": methodType,
    "accountName": accountName,
    "bankName": bankName,
    "accountNumber": accountNumber,
  };
}
