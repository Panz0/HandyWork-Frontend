import 'dart:convert';
import 'package:http/http.dart' as http;

import '../brosepage/filterdroplist.dart';
import '../main.dart';



List<Map<String,dynamic>> alljobs =[];
var allpagesnum;
var numberofalljobs;
getalljobs(String _usertoken,int _parmspage,String city,String field) async {

  alljobs =[];
  listcity=[];
  listfield=[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/job/all?page=${_parmspage}";

  if(city!=""){
    url="https://polite-puma-8.telebit.io/handywork/v1/job/all?page=${_parmspage}&city=${city}";
  }
  if(field!=""){
    url="https://polite-puma-8.telebit.io/handywork/v1/job/all?page=${_parmspage}&field=${field}";
  }
  if(city!=""&&field!=""){
    url="https://polite-puma-8.telebit.io/handywork/v1/job/all?page=${_parmspage}&city=${city}&field=${field}";
  }
  //"https://polite-puma-8.telebit.io/handywork/v1/job/all" '?page=${_parmspage}'
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${_usertoken}"});
  //print(res.body);
  var _respconverted= getalljobsFromJson(res.body);
  allpagesnum= _respconverted.numOfPages;
  //قبل ما تراجع الحكي هاظ  روح اعملك كاسه شاي وصلي وارجع ادعي الله انك ترجع تفهمو
  for (int i=0;i<_respconverted.jobs.length;i++){
    Map<String,dynamic> k = {};
    k["owner"]=_respconverted.jobs[i].owner;
    k["id"]=_respconverted.jobs[i].id;
    k["field"]=_respconverted.jobs[i].field;
    k["city"]=_respconverted.jobs[i].city;
    k["description"]=_respconverted.jobs[i].description;
    k["publishDate"]=_respconverted.jobs[i].publishDate.toString().substring(0,10);
    k["updateDate"]=_respconverted.jobs[i].updateDate == "" ? "" :_respconverted.jobs[i].updateDate.toString().substring(0,10);
    k["jobName"]=_respconverted.jobs[i].jobName;
    k["imagesUrls"]= _respconverted.jobs[i].imagesUrls;//converting links to string into a list of string with length of images.length
    //}
    listfield.add(_respconverted.jobs[i].field);
    // // print(imgslength);//1
    //// print(k["imagesUrls"]);// the image link
    alljobs.add(k);
  }
  numberofalljobs=_respconverted.jobs.length;
  ////print(ownedjobs[0]["done"]);
  ////print("${ownedjobs[0]["imagesUrls"]}");

  print(allpagesnum);
  print(numberofalljobs);
  listcity =<String>['CITY','IRBED','JERASH','AJLOUN','AMMAN','BALQAA','ZARQAA','MAFRAQ','MAAN','KARAK','AQABA','MADABA'];
  //print(alljobs);
  return alljobs;

}


Getalljobs getalljobsFromJson(String str) => Getalljobs.fromJson(json.decode(str));

String getalljobsToJson(Getalljobs data) => json.encode(data.toJson());

class Getalljobs {
  Getalljobs({
    required this.jobs,
    required this.numOfPages,
  });

  List<Job> jobs;
  int numOfPages;

  factory Getalljobs.fromJson(Map<String, dynamic> json) => Getalljobs(
    jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
    numOfPages: json["numOfPages"],
  );

  Map<String, dynamic> toJson() => {
    "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
    "numOfPages": numOfPages,
  };
}

class Job {
  Job({
    required this.id,
    required this.owner,
    required this.field,
    required this.description,
    required this.publishDate,
    required this.updateDate,
    required this.jobName,
    required this.imagesUrls,
    required this.city,
  });

  int id;
  String owner;
  String field;
  String description;
  DateTime publishDate;
  String updateDate;
  String jobName;
  List<String> imagesUrls;
  String city;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["id"],
    owner: json["owner"],
    field: json["field"],
    description: json["description"],
    publishDate: DateTime.parse(json["publishDate"]),
    updateDate: json["updateDate"] == null ?"":json["updateDate"],
    jobName: json["jobName"],
    imagesUrls: List<String>.from(json["imagesUrls"].map((x) => x)),
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner": owner,
    "field": field,
    "description": description,
    "publishDate": publishDate.toIso8601String(),
    "updateDate": updateDate,
    "jobName": jobName,
    "imagesUrls": List<dynamic>.from(imagesUrls.map((x) => x)),
    "city": city,
  };
}