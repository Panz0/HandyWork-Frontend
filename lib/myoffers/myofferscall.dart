import 'package:http/http.dart' as http;
import 'dart:convert';


var myofferslist =[];
getoffersonmyjob({required String usertoken,required String username})async{
  myofferslist =[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/user/${username}/offers";
  var res= await http.get(Uri.parse(url),headers: {"Authorization": "Bearer ${usertoken}"});
  var respc=offerscallFromJson(res.body);
  // print('the length is ${respc.length}');
  for (int i=0;i<respc.length;i++){
    var k = {};
    k["offerid"]=respc[i].id;
    k["jobTitle"]=respc[i].jobTitle;
    k["jobId"]=respc[i].jobId;
    k["jobImageUrl"]=respc[i].jobImageUrl;
    k["user"]=respc[i].user;
    k["userImageUrl"]=respc[i].userImageUrl;
    k["suggestedAmount"]=respc[i].suggestedAmount;
    k["accepted"]=respc[i].accepted;
    k["rejected"]=respc[i].rejected;
    // // print(imgslength);//1
    //// print(k["imagesUrls"]);// the image link
    myofferslist.add(k);
  }
}


List<Offersonmyjobcall> offerscallFromJson(String str) => List<Offersonmyjobcall>.from(json.decode(str).map((x) => Offersonmyjobcall.fromJson(x)));

String offerscallToJson(List<Offersonmyjobcall> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offersonmyjobcall {
  int id;
  String jobTitle;
  int jobId;
  String jobImageUrl;
  String user;
  String userImageUrl;
  int suggestedAmount;
  bool accepted;
  bool rejected;

  Offersonmyjobcall({
    required this.id,
    required this.jobTitle,
    required this.jobId,
    required this.jobImageUrl,
    required this.user,
    required this.userImageUrl,
    required this.suggestedAmount,
    required this.accepted,
    required this.rejected,
  });

  factory Offersonmyjobcall.fromJson(Map<String, dynamic> json) => Offersonmyjobcall(
    id: json["id"],
    jobTitle: json["jobTitle"],
    jobId: json["jobId"],
    jobImageUrl: json["jobImageUrl"],
    user: json["user"],
    userImageUrl: json["userImageUrl"],
    suggestedAmount: json["suggestedAmount"],
    accepted: json["accepted"],
    rejected: json["rejected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jobTitle": jobTitle,
    "jobId": jobId,
    "jobImageUrl": jobImageUrl,
    "user": user,
    "userImageUrl": userImageUrl,
    "suggestedAmount": suggestedAmount,
    "accepted": accepted,
    "rejected": rejected,
  };
}