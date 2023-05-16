import 'package:http/http.dart' as http;

import '../homepagematerial/myjobs/reviewsonmyjobcall.dart';
List aslisterlistmy =[];
List astakerlistmy =[];

List aslisterlistofferedby =[];
List astakerlistofferedby =[];

List aslisterlistlistedby =[];
List astakerlistlistedby =[];

main()async{
 await ratingspageasbothcall('test1', 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MSIsImlhdCI6MTY4MzY1MDkyNCwiZXhwIjo5MjIzMzcyMDM2ODU0Nzc1fQ.BfcOtISuV--q5ERjIsJJBr-F2g9_W8RGEZKdBhkW0ds', 'my', 'USER_REVIEW');
}
ratingspageasbothcall(String username,String token,String forwho,String parmtype)async{
if(parmtype=='USER_REVIEW'&&forwho=='my'){
  aslisterlistmy =[];
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/reviews?type=${parmtype}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
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
    aslisterlistmy.add(k);
  }
  // print(aslisterlistmy);
}

if(parmtype=='JOB_REVIEW'&&forwho=='my'){
  astakerlistmy =[];
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/reviews?type=${parmtype}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
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
    astakerlistmy.add(k);
  }
}

if(parmtype=='USER_REVIEW'&&forwho=='offeredby'){
  aslisterlistofferedby =[];
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/reviews?type=${parmtype}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
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
    aslisterlistofferedby.add(k);
  }
  // print(aslisterlistmy);
}

if(parmtype=='JOB_REVIEW'&&forwho=='offeredby'){
  astakerlistofferedby =[];
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/reviews?type=${parmtype}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
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
    astakerlistofferedby.add(k);
  }
  // print(aslisterlistmy);
}

if(parmtype=='USER_REVIEW'&&forwho=='listedby'){
  aslisterlistlistedby =[];
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/reviews?type=${parmtype}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
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
    aslisterlistlistedby.add(k);
  }
  // print(aslisterlistmy);
}

if(parmtype=='JOB_REVIEW'&&forwho=='listedby'){
  astakerlistlistedby =[];
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/reviews?type=${parmtype}";
  var res = await http.get(Uri.parse(url), headers: {"Authorization": "Bearer ${token}"});
  var respc=reviewofferonmyjobcallFromJson(res.body);
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
    astakerlistlistedby.add(k);
  }
  // print(aslisterlistmy);
}
}