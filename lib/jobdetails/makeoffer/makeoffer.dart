import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:handywork0/jobdetails/makeoffer/postoffer.dart';


import '../../homepagematerial/homepage.dart';
import '../../main.dart';

popupmakeoffer(BuildContext ctx,String jobid) {
  TextEditingController makeofferfieldcontroller = TextEditingController();
  showDialog(
      useSafeArea: true,
      context: ctx,
      builder: (BuildContext ctx) {
        return  AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Make an Offer'),
          content: Container(
            height: MediaQuery.of(ctx).size.height / 5.5,
            width: MediaQuery.of(ctx).size.width,
            child: Column(
              children: [
                Row(children: [
                  Expanded(child: TextFormField(inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
                    controller:makeofferfieldcontroller,
                    keyboardType: TextInputType.phone,decoration: InputDecoration(label: Text("Amount "),suffixIcon:Icon(Icons.monetization_on)),))
                ],),
                SizedBox(height: 10),
                Container(height: MediaQuery.of(ctx).size.height*0.1,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: ()async{
                        if(makeofferfieldcontroller.text.isNotEmpty){
                        var makeofferfieldint=int.parse(makeofferfieldcontroller.text);
                        print(makeofferfieldint);

                          await postoffer(makeofferfieldint,jobid,Usertokenallpages,ctx);

                        }else{
                          // ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                          //     content: Text("You cant just get it for free!"),
                          //     duration: Duration(seconds: 3)));
                         // Navigator.of(ctx).pop();

                        }},
                          child: Text('Make it'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),
                    ],),
                )

              ],
            ),
          ),
        );
      });
}
