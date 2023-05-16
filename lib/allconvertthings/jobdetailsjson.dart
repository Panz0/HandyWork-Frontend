import 'dart:convert';
import 'package:http/http.dart' as http;

main(){
  getingdetailsjob();
}

Map<String,dynamic> onejobdetails = {};

getingdetailsjob()async{
  var url="https://polite-puma-8.telebit.io/handywork/v1/job/20";
  var res= await http.get(Uri.parse(url), headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJJbkt5IiwiaWF0IjoxNjgwMjA2NjcyLCJleHAiOjkyMjMzNzIwMzY4NTQ3NzV9.mPuribpeDLjaE9khoPa-WnH6FhL_MOUgT7kLwL5_YGo"});
  var respconverted = await jobdetailsjsonFromJson(res.body);

  onejobdetails["id"]=respconverted.id;
  onejobdetails["owner"]=respconverted.owner;
  onejobdetails["doneBy"]=respconverted.doneBy;
  onejobdetails["field"]=respconverted.field;
  onejobdetails["description"]=respconverted.description;
  onejobdetails["publishDate"]=respconverted.publishDate.toString().substring(0,10);
  onejobdetails["updateDate"]=respconverted.updateDate == "" ? "" :respconverted.updateDate.toString().substring(0,10);
  onejobdetails["jobName"]=respconverted.jobName;
  onejobdetails["imagesUrls"]=respconverted.imagesUrls;
  onejobdetails["done"]=respconverted.done;
  onejobdetails["city"]=respconverted.city;
  //print(onejobdetails);
}






Jobdetailsjson jobdetailsjsonFromJson(String str) => Jobdetailsjson.fromJson(json.decode(str));

String jobdetailsjsonToJson(Jobdetailsjson data) => json.encode(data.toJson());

class Jobdetailsjson {
  Jobdetailsjson({
    required this.id,
    required this.owner,
    this.doneBy,
    required this.field,
    required this.description,
    required this.publishDate,
    required this.updateDate,
    required this.jobName,
    required this.imagesUrls,
    required this.done,
    required this.city,
  });

  int id;
  String owner;
  dynamic doneBy;
  String field;
  String description;
  DateTime publishDate;
  dynamic updateDate;
  String jobName;
  List<String> imagesUrls;
  bool done;
  String city;

  factory Jobdetailsjson.fromJson(Map<String, dynamic> json) => Jobdetailsjson(
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