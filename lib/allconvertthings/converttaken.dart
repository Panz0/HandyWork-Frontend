import 'dart:convert';

Convertingtaken convertingtakenFromJson(String str) =>
    Convertingtaken.fromJson(json.decode(str));

String convertingtakenToJson(Convertingtaken data) =>
    json.encode(data.toJson());

class Convertingtaken {
  Convertingtaken({
    required this.message,
  });

  Message message;

  factory Convertingtaken.fromJson(Map<String, dynamic> json) =>
      Convertingtaken(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.phoneNumber,
    required this.email,
    required this.username,
  });

  String phoneNumber;
  String email;
  String username;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        phoneNumber: json["phoneNumber"] == null ? "" : json["phoneNumber"],
        email: json["email"] == null ? "" : json["email"],
        username: json["username"] == null ? "" : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "email": email,
        "username": username,
      };
}
