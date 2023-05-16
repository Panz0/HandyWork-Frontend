// To parse this JSON data, do
//
//     final updatepassword = updatepasswordFromJson(jsonString);

import 'dart:convert';

Updatepassword updatepasswordFromJson(String str) => Updatepassword.fromJson(json.decode(str));

String updatepasswordToJson(Updatepassword data) => json.encode(data.toJson());

class Updatepassword {
  Updatepassword({
    required this.password,
  });

  String password;

  factory Updatepassword.fromJson(Map<String, dynamic> json) => Updatepassword(
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
  };
}
