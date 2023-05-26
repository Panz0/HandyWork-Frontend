import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../homepagematerial/homepage.dart';

postoffer(int amount, String jobid ,String usertoken ,BuildContext context)async{
  if(amount == 0){
    amount =1;
  }
    final datamodelsave = await Jsonmakeoffer(suggestedAmount: amount);
    var url =
        "https://polite-puma-8.telebit.io/handywork/v1/job/${jobid}/makeOffer";
    var jdata = jsonmakeofferToJson(datamodelsave);
    var res = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${usertoken}",
          "content-type": "application/json"
        },
        body: jdata);
    print(res.statusCode);
    if (res.statusCode == 200) {
      EasyLoading.showToast("you made a Deal",duration: Duration(seconds: 3));
     // EasyLoading.dismiss();
      Navigator.of(context).pop();

    }
}

Jsonmakeoffer jsonmakeofferFromJson(String str) => Jsonmakeoffer.fromJson(json.decode(str));

String jsonmakeofferToJson(Jsonmakeoffer data) => json.encode(data.toJson());

class Jsonmakeoffer {
  int suggestedAmount;

  Jsonmakeoffer({
    required this.suggestedAmount,
  });

  factory Jsonmakeoffer.fromJson(Map<String, dynamic> json) => Jsonmakeoffer(
    suggestedAmount: json["suggestedAmount"],
  );

  Map<String, dynamic> toJson() => {
    "suggestedAmount": suggestedAmount,
  };
}
