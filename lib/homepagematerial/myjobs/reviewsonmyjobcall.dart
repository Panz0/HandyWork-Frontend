import 'package:http/http.dart' as http;
import 'dart:convert';

List myjobreviews =[];
getreviewsnmyjob({required String usertoken,required int jobid})async{
  myjobreviews =[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/job/${jobid}/reviews";
  var res= await http.get(Uri.parse(url),headers: {"Authorization": "Bearer ${usertoken}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
  print(res.body);
  // print('the length is ${respc.length}');
  for (int i=0;i<respc.length;i++){
    var k = {};
    k["reviewid"]=respc[i].id;
    k["jobId"]=respc[i].jobId;
    k["jobName"]=respc[i].jobName;
    k["byUserUsername"]=respc[i].byUserUsername;
    k["byUserUsernameImageUrl"]=respc[i].byUserUsernameImageUrl;
    k["onUserUsername"]=respc[i].onUserUsername;
    k["onUserUsernameImageUrl"]=respc[i].onUserUsernameImageUrl;
    k["type"]=respc[i].type;
    k["rating"]=respc[i].rating;
    k["publishDate"]=respc[i].publishDate.toString().substring(0,10);
    k["updateDate"]=respc[i].updateDate ==""||respc[i].updateDate ==null? "" :respc[i].updateDate;
    k["reviewText"]=respc[i].reviewText;
    // // print(imgslength);//1
    //// print(k["imagesUrls"]);// the image link
    myjobreviews.add(k);
  }

}


List<Reviewofferonmyjobcall> reviewofferonmyjobcallFromJson(String str) => List<Reviewofferonmyjobcall>.from(json.decode(str).map((x) => Reviewofferonmyjobcall.fromJson(x)));

String reviewofferonmyjobcallToJson(List<Reviewofferonmyjobcall> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reviewofferonmyjobcall {
  int id;
  int jobId;
  String jobName;
  String byUserUsername;
  String byUserUsernameImageUrl;
  String onUserUsername;
  String onUserUsernameImageUrl;
  String type;
  int rating;
  DateTime publishDate;
  dynamic updateDate;
  String reviewText;

  Reviewofferonmyjobcall({
    required this.id,
    required this.jobId,
    required this.jobName,
    required this.byUserUsername,
    required this.byUserUsernameImageUrl,
    required this.onUserUsername,
    required this.onUserUsernameImageUrl,
    required this.type,
    required this.rating,
    required this.publishDate,
    this.updateDate,
    required this.reviewText,
  });

  factory Reviewofferonmyjobcall.fromJson(Map<String, dynamic> json) => Reviewofferonmyjobcall(
    id: json["id"],
    jobId: json["jobId"],
    jobName: json["jobName"],
    byUserUsername: json["byUserUsername"],
    byUserUsernameImageUrl: json["byUserUsernameImageUrl"],
    onUserUsername: json["onUserUsername"],
    onUserUsernameImageUrl: json["onUserUsernameImageUrl"],
    type: json["type"],
    rating: json["rating"],
    publishDate: DateTime.parse(json["publishDate"]),
    updateDate: json["updateDate"],
    reviewText: json["reviewText"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jobId": jobId,
    "jobName": jobName,
    "byUserUsername": byUserUsername,
    "byUserUsernameImageUrl": byUserUsernameImageUrl,
    "onUserUsername": onUserUsername,
    "onUserUsernameImageUrl": onUserUsernameImageUrl,
    "type": type,
    "rating": rating,
    "publishDate": publishDate.toIso8601String(),
    "updateDate": updateDate,
    "reviewText": reviewText,
  };
}
