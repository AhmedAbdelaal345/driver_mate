import 'dart:convert';

class MaintanceHistoryModel {
  final String centerName;
  final String typeOfService;
  final String location;
  final String state;
  final String phone;
  final DateTime date;
  final double price;
  final String? notes; // 👈 optional field

  MaintanceHistoryModel({
    required this.centerName,
    required this.typeOfService,
    required this.location,
    required this.state,
    required this.date,
    required this.price,
    required this.phone,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      "centerName": centerName,
      "typeOfService": typeOfService,
      "location": location,
      "state": state,
      "date": date.toIso8601String(),
      "price": price,
      "notes": notes,
    };
  }

  factory MaintanceHistoryModel.fromMap(Map<String, dynamic> map) {
    return MaintanceHistoryModel(
      centerName: map["centerName"],
      typeOfService: map["typeOfService"],
      location: map["location"],
      state: map["state"],
      date: DateTime.parse(map["date"]),
      phone: map["phone"],
      price: map["price"],
      notes: map["notes"],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory MaintanceHistoryModel.fromJson(String source) =>
      MaintanceHistoryModel.fromMap(jsonDecode(source));
}
