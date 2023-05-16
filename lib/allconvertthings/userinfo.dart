import 'package:http/http.dart' as http;
import 'convertjson.dart';
import 'dart:convert';

var myprofileuserinfo= {};
getinguserinfo(String _user,String _usertoken)async{
  String url = "https://polite-puma-8.telebit.io/handywork/v1/user/${_user}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${_usertoken}"});
  print(res.body);
  var respconverted = await myprofileuserinfoFromJson(res.body);
  myprofileuserinfo['username']=respconverted.username;
  myprofileuserinfo['firstName']=respconverted.firstName;
  myprofileuserinfo['lastName']=respconverted.lastName;
  myprofileuserinfo['email']=respconverted.email;
  myprofileuserinfo['phoneNumber']=respconverted.phoneNumber;
  myprofileuserinfo['pfpUrl']=respconverted.pfpUrl;
  myprofileuserinfo['city']=respconverted.city;
}



Myprofileuserinfo myprofileuserinfoFromJson(String str) => Myprofileuserinfo.fromJson(json.decode(str));

String myprofileuserinfoToJson(Myprofileuserinfo data) => json.encode(data.toJson());

class Myprofileuserinfo {
  Myprofileuserinfo({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.pfpUrl,
    required this.city,
  });

  String username;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String pfpUrl;
  String city;

  factory Myprofileuserinfo.fromJson(Map<String, dynamic> json) => Myprofileuserinfo(
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    pfpUrl: json["pfpUrl"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "pfpUrl": pfpUrl,
    "city": city,
  };
}