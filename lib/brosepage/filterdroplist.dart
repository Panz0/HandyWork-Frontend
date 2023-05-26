import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/brosepage/browsepage.dart';

import '../allconvertthings/getalljobs.dart';
import '../main.dart';
import '../homepagematerial/homepage.dart';

List<String>  listfield = <String>[];//'njar','njar','znje','7dad','Al-znje','flafel'
List<String>  listcity =<String>['CITY','IRBED','JERASH','AJLOUN','AMMAN','BALQAA','ZARQAA','MAFRAQ','MAAN','KARAK','AQABA','MADABA'];

var filteredcity='';
var filteredfield='';
var dropdownfinalfilter;
    //  filterby(BuildContext ctx) async{
    //
    //    filteredcity='';
    //    filteredfield='';
    //    dropdownfinalfilter='';
    //   showDialog(
    //       useSafeArea: true,
    //      context: ctx,
    //      //useRootNavigator: true,
    //
    //       builder: (BuildContext ctx1) {
    //         return  AlertDialog(
    //             shape:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //             title: Text('Filter By'),
    //             content: Container(
    //               height: MediaQuery.of(ctx1).size.height / 5.5,
    //               width: MediaQuery.of(ctx1).size.width,
    //               child: Column(
    //                 children: [
    //                   Row(children: [
    //                    Text("City:  "),
    //                     DropdownButtonCity(),
    //                   //   Expanded(child: Container(width: MediaQuery.of(ctx).size.width*0.25,
    //                   //     child: Autocomplete(
    //                   //       optionsBuilder: (textEditingValue) {
    //                   //         if(textEditingValue.text == ''){
    //                   //           return const Iterable<String>.empty();
    //                   //         }
    //                   //         filteredcity=textEditingValue.text;
    //                   //         return listcity.where((String element) =>element.contains(textEditingValue.text));
    //                   //
    //                   //       },)
    //                   // ),),
    //                     ],),
    //                   SizedBox(height: 4),
    //                   Row(children: [
    //                     Text("Field: "),
    //                     Container(width: MediaQuery.of(ctx1).size.width*0.17,
    //                       child: Autocomplete(
    //                         optionsBuilder: (textEditingValue) {
    //                           if(textEditingValue.text == ''){
    //                             return const Iterable<String>.empty();
    //                           }
    //                           filteredfield=textEditingValue.text;
    //                           return listfield.where((String element) =>element.contains(textEditingValue.text));
    //
    //                         },),
    //                     ),
    //                   ],),
    //                   SizedBox(height: 5),
    //                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                    children: [
    //                      ElevatedButton(onPressed: ()async{
    //
    //                        filteredcity='';
    //                        print(filteredfield);
    //                        filteredfield='';
    //                        await getalljobs(Usertokenallpages,0,filteredcity,filteredfield);
    //
    //                        // Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => homepage(),));
    //                        Navigator.pop(ctx1);
    //                        //Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) => const homepage()));
    //                      },
    //                          child: Text('Reset'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),
    //
    //                    ElevatedButton(onPressed: ()async{
    //
    //                      print('eljowab el final is ${dropdownfinalfilter}');
    //                      if(dropdownfinalfilter!='CITY'){
    //                        filteredcity=dropdownfinalfilter;
    //                      }else{
    //                        filteredcity='';
    //                        print(filteredcity);
    //                      }
    //                      print(filteredcity);
    //                      print(filteredfield);
    //                      if(filteredfield==null){filteredfield='';}
    //                      await getalljobs(Usertokenallpages,0,filteredcity,filteredfield);
    //                     //filteredcity='';
    //                     // filteredfield='';
    //
    //                      Navigator.pop(ctx1);
    //
    //                     // Navigator.of(ctx1).pushReplacement(MaterialPageRoute(builder: (context) => homepage(),));
    //                    },
    //                        child: Text('Save'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),
    //
    //
    //                  ],)
    //
    //                 ],
    //               ),
    //             ),
    //         );
    //       });
    // }



class DropdownButtonCity extends StatefulWidget {
  const DropdownButtonCity({super.key});

  @override
  State<DropdownButtonCity> createState() => _DropdownButtonCityState();
}

class _DropdownButtonCityState extends State<DropdownButtonCity> {
  String dropdownValue = listcity[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          dropdownfinalfilter =value!;
        });
      },
      items: <String>['CITY','IRBED','JERASH','AJLOUN','AMMAN','BALQAA','ZARQAA','MAFRAQ','MAAN','KARAK','AQABA','MADABA'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}






