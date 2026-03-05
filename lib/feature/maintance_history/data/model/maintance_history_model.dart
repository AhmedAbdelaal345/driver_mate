import 'dart:convert';

class MaintanceHistoryModel {
  final String centerName;
  final String typeOfService;
  final String location;
  final String state;
  final DateTime date;
  final double price;

  MaintanceHistoryModel({
    required this.centerName,
    required this.typeOfService,
    required this.location,
    required this.state,
    required this.date,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "centerName": centerName,
      "typeOfService": typeOfService,
      "location": location,
      "state": state,
      "date": date.toIso8601String(),
      "price": price,
    };
  }

  factory MaintanceHistoryModel.fromMap(Map<String, dynamic> map) {
    return MaintanceHistoryModel(
      centerName: map["centerName"],
      typeOfService: map["typeOfService"],
      location: map["location"],
      state: map["state"],
      date: DateTime.parse(map["date"]),
      price: map["price"],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory MaintanceHistoryModel.fromJson(String source) =>
      MaintanceHistoryModel.fromMap(jsonDecode(source));
}