import 'dart:convert';
//after a success registeration ill get a resp with token
convertingtoken convertingtokenFromJson(String str) => convertingtoken.fromJson(json.decode(str));

String convertingtokenToJson(convertingtoken data) => json.encode(data.toJson());

class convertingtoken {
  convertingtoken({
    required this.token,
  });

  String token;

  factory convertingtoken.fromJson(Map<String, dynamic> json) => convertingtoken(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}