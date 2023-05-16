
import 'dart:convert';

UpdatefirsthalfJson updatefirsthalfJsonFromJson(String str) => UpdatefirsthalfJson.fromJson(json.decode(str));

String updatefirsthalfJsonToJson(UpdatefirsthalfJson data) => json.encode(data.toJson());

class UpdatefirsthalfJson {
  UpdatefirsthalfJson({
    required this.message,
  });

  Message message;

  factory UpdatefirsthalfJson.fromJson(Map<String, dynamic> json) => UpdatefirsthalfJson(
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
  });

  String phoneNumber;
  String email;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    phoneNumber: json["phoneNumber"] == null?"":json["phoneNumber"],
    email: json["email"] == null?"":json["email"],
  );

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
    "email": email,
  };
}

