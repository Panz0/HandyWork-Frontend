import 'dart:convert';
Signintoken signintokenFromJson(String str) => Signintoken.fromJson(json.decode(str));
//converting  user and pass to json to send it  to backend
String signintokenToJson(Signintoken data) => json.encode(data.toJson());

class Signintoken{
  Signintoken({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory Signintoken.fromJson(Map<String, dynamic> json) => Signintoken(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}