// /review/id/delete
// delete



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
deleteoffercall({required BuildContext ctx,required String usertoken,required int offerid})async{
  //myjoboffers =[];
  var url="https://polite-puma-8.telebit.io/handywork/v1/offer/${offerid}/delete";
  var res= await http.delete(Uri.parse(url),headers: {"Authorization": "Bearer ${usertoken}","content-type": "application/json"});
  print(res.statusCode);
  print(res.body);
  if(res.statusCode==200){
    ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
                "Deleted "),
            duration: Duration(seconds: 3)));

   // int count = 0;
    //Navigator.of(ctx).popUntil((_) => count++ >= 2);
  }
}