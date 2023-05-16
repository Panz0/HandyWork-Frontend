import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../homepagematerial/homepage.dart';

List<Map<String,dynamic>> ownedjobs =[];
var myjobslength;
getownjobs(String _user,String _usertoken) async {
  ownedjobs=[];
 // print(_user);
  //print(_usertoken);
  String url = "https://polite-puma-8.telebit.io/handywork/v1/user/${_user}/job/all";
 // print(url);
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${_usertoken}"});
  var respconverted= getownjobsMFromJson(res.body);
 // print(res.body);
 //print(respconverted[1].imagesUrls.length);
 // print(res.body);
  //print(respconverted.length);
  //قبل ما تراجع الحكي هاظ  روح اعملك كاسه شاي وصلي وارجع ادعي الله انك ترجع تفهمو
  for (int i=0;i<respconverted.length;i++){
    List<String>imgs=[];
    Map<String,dynamic> k = {};
    k["id"]=respconverted[i].id;
    k["owner"]=respconverted[i].owner;
    k["doneby"]=respconverted[i].doneBy;
    k["field"]=respconverted[i].field;
    k["city"]=respconverted[i].city;
    k["description"]=respconverted[i].description;
    k["publishDate"]=respconverted[i].publishDate.toString().substring(0,10);
    k["updateDate"]=respconverted[i].updateDate == "" ? "" :respconverted[i].updateDate.toString().substring(0,10);
    k["jobName"]=respconverted[i].jobName;
    k["done"]=respconverted[i].done;
    k["imagesUrls"]=[respconverted[i].imagesUrls.length];//the size of the images
   //var imgslength= (respconverted[i].imagesUrls.length);
   //for (int l=0;l<imgslength;l++){
     imgs = respconverted[i].imagesUrls;
    k["imagesUrls"]= imgs;
    // k["imagesUrls"]= respconverted[i].imagesUrls;//converting links to string into a list of string with length of images.length
   //}

 // // print(imgslength);//1
   //// print(k["imagesUrls"]);// the image link
    ownedjobs.add(k);
  }
  ////print(ownedjobs[0]["done"]);
  ////print("${ownedjobs[0]["imagesUrls"]}");

   myjobslength=ownedjobs.length;
  print("ownerd job ${ownedjobs}");
  return ownedjobs;

}



List<GetownjobsM> getownjobsMFromJson(String str) => List<GetownjobsM>.from(json.decode(str).map((x) => GetownjobsM.fromJson(x)));

String getownjobsMToJson(List<GetownjobsM> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetownjobsM {
  GetownjobsM({
    required this.id,
    required this.owner,
    required this.doneBy,
    required this.field,
    required this.description,
    required this.publishDate,
    this.updateDate,
    required this.jobName,
    required this.imagesUrls,
    required this.done,
    required this.city,
  });

  int id;
  String owner;
  String doneBy;
  String field;
  String description;
  DateTime publishDate;
  dynamic updateDate;
  String jobName;
  List<String> imagesUrls;
  bool done;
  String city;

  factory GetownjobsM.fromJson(Map<String, dynamic> json) => GetownjobsM(
    id: json["id"],
    owner: json["owner"],
    doneBy: json["doneBy"],
    field: json["field"],
    description: json["description"],
    publishDate: DateTime.parse(json["publishDate"]),
    updateDate: json["updateDate"] == null ?"":json["updateDate"],
    jobName: json["jobName"],
    imagesUrls: List<String>.from(json["imagesUrls"].map((x) => x)),
    done: json["done"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner": owner,
    "doneBy": doneBy,
    "field": field,
    "description": description,
    "publishDate": publishDate.toIso8601String(),
    "updateDate": updateDate,
    "jobName": jobName,
    "imagesUrls": List<dynamic>.from(imagesUrls.map((x) => x)),
    "done": done,
    "city": city,
  };
}



Future<List<Map<String, dynamic>>> ownedjobslist()async{
  return ownedjobs;
}