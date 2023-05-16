
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../allconvertthings/getownjobs.dart';
import '../../main.dart';
import '../../myoffers/myofferscall.dart';

deletejobcall({required BuildContext ctx,required String usertoken,required int jobid})async{
  //myjoboffers =[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/job/${jobid}/delete";
  var res= await http.delete(Uri.parse(url),headers: {"Authorization": "Bearer ${usertoken}","content-type": "application/json"});
  print(res.statusCode);
  print(res.body);
  if(res.statusCode==200){
    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
                "Deleted "),
            duration: Duration(seconds: 3)));
    await getownjobs(userNameFromToken,Usertokenallpages);
    await getoffersonmyjob(usertoken: Usertokenallpages, username: userNameFromToken);
     int count = 0;
    Navigator.of(ctx).popUntil((_) => count++ >= 2);
  }
}







// To parse this JSON data, do
//
//     final editjobcall = editjobcallFromJson(jsonString);


Editjobcall editjobcallFromJson(String str) => Editjobcall.fromJson(json.decode(str));

String editjobcallToJson(Editjobcall data) => json.encode(data.toJson());

class Editjobcall {
  String jobName;
  String field;
  String city;
  String description;

  Editjobcall({
    required this.jobName,
    required this.field,
    required this.city,
    required this.description,
  });

  factory Editjobcall.fromJson(Map<String, dynamic> json) => Editjobcall(
    jobName: json["jobName"],
    field: json["field"],
    city: json["city"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "jobName": jobName,
    "field": field,
    "city": city,
    "description": description,
  };
}
