import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handywork0/allconvertthings/taketoken.dart';
import 'package:http/http.dart' as http;

import '../homepagematerial/homepage.dart';



sendreviewoffer({required BuildContext ctx,required String usertoken,required int jobid,required int rating,required String reviewtext})async{

  final datamodelsave = await Reviewofferonmyjobcall(
      rating: rating,
      reviewText: reviewtext
  );
  //myjoboffers =[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/job/${jobid}/makeReview";
  var jdata=reviewofferonmyjobcallToJson(datamodelsave);
  var res= await http.post(Uri.parse(url),headers: {"Authorization": "Bearer ${usertoken}","content-type": "application/json"},body:jdata);
  print(res.statusCode);
  if(res.statusCode==200){
    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
                "submitted "),
            duration: Duration(seconds: 3)));
    Navigator.of(ctx).pop();
  }
  if(res.statusCode==401||res.statusCode==403){
    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
                "You already have a review"),
            duration: Duration(seconds: 3)));
  }


  }

sendreviewofferedit({required BuildContext ctx,required String usertoken,required int reviewid,required int rating,required String reviewtext})async{

  final datamodelsave = await Reviewofferonmyjobcall(
      rating: rating,
      reviewText: reviewtext
  );
  //myjoboffers =[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/review/${reviewid}/update";
  var jdata=reviewofferonmyjobcallToJson(datamodelsave);
  var res= await http.patch(Uri.parse(url),headers: {"Authorization": "Bearer ${usertoken}","content-type": "application/json"},
      body:jdata);
  print(res.statusCode);
  if(res.statusCode==200){

    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
                "Edited "),
            duration: Duration(seconds: 3)));

    int count = 0;
    Navigator.of(ctx).popUntil((_) => count++ >= 2);
  }
  if(res.statusCode==401||res.statusCode==403){
    print(res.body);
    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
                ""),
            duration: Duration(seconds: 3)));
  }


}








Reviewofferonmyjobcall reviewofferonmyjobcallFromJson(String str) => Reviewofferonmyjobcall.fromJson(json.decode(str));

String reviewofferonmyjobcallToJson(Reviewofferonmyjobcall data) => json.encode(data.toJson());

class Reviewofferonmyjobcall {
  int rating;
  String reviewText;

  Reviewofferonmyjobcall({
    required this.rating,
    required this.reviewText,
  });

  factory Reviewofferonmyjobcall.fromJson(Map<String, dynamic> json) => Reviewofferonmyjobcall(
    rating: json["rating"],
    reviewText: json["reviewText"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "reviewText": reviewText,
  };
}
