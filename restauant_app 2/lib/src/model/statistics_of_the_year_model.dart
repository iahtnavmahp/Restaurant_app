class StatisticsOfTheYearModel {
  StatisticsOfTheYearModel({
    this.year,
    this.month,
    this.day,
    this.totalPrice,
  });

  String year;
  String month;
  String day;
  double totalPrice;

  factory StatisticsOfTheYearModel.fromJson(Map<String, dynamic> json) => StatisticsOfTheYearModel(
    year: json["year"],
    month: json["month"],
    day: json["day"],
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "day": day,
    "totalPrice": totalPrice,
  };
}
