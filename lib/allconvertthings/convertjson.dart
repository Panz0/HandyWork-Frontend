import 'dart:convert';

Converting convertingFromJson(String str) =>
    Converting.fromJson(json.decode(str));

String convertingToJson(Converting data) => json.encode(data.toJson());

class Converting {
  Converting({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.pfpFile,
  });

  String username;
  String password;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String city;
  String pfpFile;

  factory Converting.fromJson(Map<String, dynamic> json) => Converting(
        username: json["username"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        city: json["city"],
        pfpFile: json["pfpFile"]
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "firstName": firstName == "" ? null : firstName,
        "lastName": lastName == "" ? null : lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "city": city,
        "pfpFile" :  pfpFile  == "" ? null : pfpFile,
      };
}
