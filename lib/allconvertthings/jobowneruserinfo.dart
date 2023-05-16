// To parse this JSON data, do
//
//     final jobowneruserinfoconvert = jobowneruserinfoconvertFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
var jobownerpic;
var jobownerusername;
var firstName;
var lastName;
var email;
var phoneNumber;
var city;

var jobownerpic2;
var jobownerusername2;
var firstName2;
var lastName2;
var email2;
var phoneNumber2;
var city2;


var  asListerRatingmy;
var  asProfessionalRatingmy;

var  asListerRatingofferedby;
var  asProfessionalRatingofferedby;

var  asListerRatinglistedby;
var  asProfessionalRatinglistedby;


List<Widget>asListerstarsmy=[];
List<Widget>asProfessionalmy=[];

List<Widget>asListerstarsofferedby=[];
List<Widget>asProfessionalofferedby=[];

List<Widget>asListerstarslistedby=[];
List<Widget>asProfessionallistedby=[];


anyuserprofile(String username,String token)async{
  jobownerpic='';
  jobownerusername='';
  firstName='';
  lastName='';
  email='';
  phoneNumber='';
  city='';
  var url="https://polite-puma-8.telebit.io/handywork/v1/user/${username}";
  var res= await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respconverted = jobowneruserinfoconvertFromJson(res.body);
  jobownerpic =respconverted.pfpUrl;
  jobownerusername=respconverted.username;
  firstName=respconverted.firstName;
  lastName=respconverted.lastName;
  email=respconverted.email;
  phoneNumber=respconverted.phoneNumber;
  city=respconverted.city;
}

anyuserprofile2(String username,String token)async{
  jobownerpic2='';
  jobownerusername2='';
  firstName2='';
  lastName2='';
  email2='';
  phoneNumber2='';
  city2='';
  var url="https://polite-puma-8.telebit.io/handywork/v1/user/${username}";
  var res= await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respconverted = jobowneruserinfoconvertFromJson(res.body);
  jobownerpic2 =respconverted.pfpUrl;
  jobownerusername2=respconverted.username;
  firstName2=respconverted.firstName;
  lastName2=respconverted.lastName;
  email2=respconverted.email;
  phoneNumber2=respconverted.phoneNumber;
  city2=respconverted.city;
}



profileratings(String username,String token,String forwho)async{

  if(forwho=='my') {

    asListerRatingmy = 0;
    asProfessionalRatingmy = 0;
    asListerstarsmy=[];
    asProfessionalmy=[];
    var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/ratings";
    var res = await http.get(
        Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
    var respconverted = myratingscallFromJson(res.body);
    asListerRatingmy=respconverted.asListerRating.ceil();
    asProfessionalRatingmy=respconverted.asProfessionalRating.ceil();
    print(res.body);
    print(asListerRatingmy);
    print(asProfessionalRatingmy);


    asListerstarsmy=[];
    if(asListerRatingmy!=-1) {
      for (int i = 1; i <= asListerRatingmy; i++) {
        asListerstarsmy.add(
            Icon(Icons.star, color: Colors.yellow, size: 20));
      }
      if (asListerstarsmy.length < 5) {
        for (int x = asListerstarsmy.length; x < 5; x++) {
          asListerstarsmy.add(
              Icon(Icons.star_outline, color: Colors.yellow, size: 20));
        }
      }
    }else{
      for (int x = 0; x < 5; x++) {
        asListerstarsmy.add(
            Icon(Icons.star_outline, color: Colors.yellow, size: 20));
      }
    }
    asProfessionalmy = [];
    if(asProfessionalRatingmy!=-1) {
      for (int i = 1; i <= asProfessionalRatingmy; i++) {
        asProfessionalmy
            .add(Icon(Icons.star, color: Colors.yellow, size: 20));
      }
      if (asProfessionalmy.length < 5) {
        for (int x = asProfessionalmy.length; x < 5; x++) {
          asProfessionalmy
              .add(Icon(Icons.star_outline, color: Colors.yellow, size: 20));
        }
      }
    }else{
      for (int x = 0; x < 5; x++) {
        asProfessionalmy
            .add(Icon(Icons.star_outline, color: Colors.yellow, size: 20));
      }
    }

  }

  if(forwho=='offeredby') {
    asListerRatingofferedby = 0;
    asProfessionalRatingofferedby = 0;
    asListerstarsofferedby=[];
    asProfessionalofferedby=[];
    var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/ratings";
    var res = await http.get(
        Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
    var respconverted = myratingscallFromJson(res.body);
    asListerRatingofferedby=respconverted.asListerRating.ceil();
    asProfessionalRatingofferedby=respconverted.asProfessionalRating.ceil();
print(res.body);
  print(asListerRatingofferedby);
  print(asProfessionalRatingofferedby);


    asListerstarsofferedby=[];
    if(asListerRatingofferedby!=-1) {
      for (int i = 1; i <= asListerRatingofferedby; i++) {
        asListerstarsofferedby.add(
            Icon(Icons.star, color: Colors.yellow, size: 20));
      }
      if (asListerstarsofferedby.length < 5) {
        for (int x = asListerstarsofferedby.length; x < 5; x++) {
          asListerstarsofferedby.add(
              Icon(Icons.star_outline, color: Colors.yellow, size: 20));
        }
      }
    }else{
      for (int x = 0; x < 5; x++) {
        asListerstarsofferedby.add(
            Icon(Icons.star_outline, color: Colors.yellow, size: 20));
      }
    }
    asProfessionalofferedby = [];
        if(asProfessionalRatingofferedby!=-1) {
      for (int i = 1; i <= asProfessionalRatingofferedby; i++) {
        asProfessionalofferedby
            .add(Icon(Icons.star, color: Colors.yellow, size: 20));
      }
      if (asProfessionalofferedby.length < 5) {
        for (int x = asProfessionalofferedby.length; x < 5; x++) {
          asProfessionalofferedby
              .add(Icon(Icons.star_outline, color: Colors.yellow, size: 20));
        }
      }
    }else{
          for (int x = 0; x < 5; x++) {
            asProfessionalofferedby
                .add(Icon(Icons.star_outline, color: Colors.yellow, size: 20));
          }
        }

  }

  if(forwho=='listedby') {
    asListerRatinglistedby = 0;
    asProfessionalRatinglistedby = 0;
    asListerstarslistedby=[];
    asProfessionallistedby=[];
    var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/ratings";
    var res = await http.get(
        Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
    var respconverted = myratingscallFromJson(res.body);
    asListerRatinglistedby=respconverted.asListerRating.ceil();
    asProfessionalRatinglistedby=respconverted.asProfessionalRating.ceil();
    print(res.body);
    print(asListerRatinglistedby);
    print(asProfessionalRatinglistedby);


    asListerstarslistedby=[];
    if(asListerRatinglistedby!=-1) {
      for (int i = 1; i <= asListerRatinglistedby; i++) {
        asListerstarslistedby.add(
            Icon(Icons.star, color: Colors.yellow, size: 20));
      }
      if (asListerstarslistedby.length < 5) {
        for (int x = asListerstarslistedby.length; x < 5; x++) {
          asListerstarslistedby.add(
              Icon(Icons.star_outline, color: Colors.yellow, size: 20));
        }
      }
    }else{
      for (int x = 0; x < 5; x++) {
        asListerstarslistedby.add(
            Icon(Icons.star_outline, color: Colors.yellow, size: 20));
      }
    }
    asProfessionallistedby = [];
    if(asProfessionalRatinglistedby!=-1) {
      for (int i = 1; i <= asProfessionalRatinglistedby; i++) {
        asProfessionallistedby
            .add(Icon(Icons.star, color: Colors.yellow, size: 20));
      }
      if (asProfessionallistedby.length < 5) {
        for (int x = asProfessionallistedby.length; x < 5; x++) {
          asProfessionallistedby
              .add(Icon(Icons.star_outline, color: Colors.yellow, size: 20));
        }
      }
    }else{
      for (int x = 0; x < 5; x++) {
        asProfessionallistedby
            .add(Icon(Icons.star_outline, color: Colors.yellow, size: 20));
      }
    }

  }
//  var respconverted = jobowneruserinfoconvertFromJson(res.body);

}



Myratingscall myratingscallFromJson(String str) => Myratingscall.fromJson(json.decode(str));

String myratingscallToJson(Myratingscall data) => json.encode(data.toJson());

class Myratingscall {
  double asListerRating;
  double asProfessionalRating;

  Myratingscall({
    required this.asListerRating,
    required this.asProfessionalRating,
  });

  factory Myratingscall.fromJson(Map<String, dynamic> json) => Myratingscall(
    asListerRating: json["asListerRating"]?.toDouble(),
    asProfessionalRating: json["asProfessionalRating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "asListerRating": asListerRating,
    "asProfessionalRating": asProfessionalRating,
  };
}

//////////////////////////////////////////////////////////////////////////////////

Jobowneruserinfoconvert jobowneruserinfoconvertFromJson(String str) => Jobowneruserinfoconvert.fromJson(json.decode(str));

String jobowneruserinfoconvertToJson(Jobowneruserinfoconvert data) => json.encode(data.toJson());

class Jobowneruserinfoconvert {
  String username;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String pfpUrl;
  String city;

  Jobowneruserinfoconvert({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.pfpUrl,
    required this.city,
  });

  factory Jobowneruserinfoconvert.fromJson(Map<String, dynamic> json) => Jobowneruserinfoconvert(
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
