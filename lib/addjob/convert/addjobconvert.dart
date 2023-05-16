// To parse this JSON data, do
//
//     final addjobconvert = addjobconvertFromJson(jsonString);

import 'dart:convert';

Addjobconvert addjobconvertFromJson(String str) => Addjobconvert.fromJson(json.decode(str));

String addjobconvertToJson(Addjobconvert data) => json.encode(data.toJson());

class Addjobconvert {
  String jobName;
  String field;
  String city;
  String description;
  List<String> imagesFiles;

  Addjobconvert({
    required this.jobName,
    required this.field,
    required this.city,
    required this.description,
    required this.imagesFiles,
  });

  factory Addjobconvert.fromJson(Map<String, dynamic> json) => Addjobconvert(
    jobName: json["jobName"],
    field: json["field"],
    city: json["city"],
    description: json["description"],
    imagesFiles: List<String>.from(json["imagesFiles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "jobName": jobName,
    "field": field,
    "city": city,
    "description": description,
    "imagesFiles": List<String>.from(imagesFiles.map((x) => x)),
  };
}
