import 'dart:convert';

Updatefirst updatefirstFromJson(String str) => Updatefirst.fromJson(json.decode(str));

String updatefirstToJson(Updatefirst data) => json.encode(data.toJson());

class Updatefirst {
  Updatefirst({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.city,
  });

  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String city;

  factory Updatefirst.fromJson(Map<String, dynamic> json) => Updatefirst(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "city": city,
  };
}
