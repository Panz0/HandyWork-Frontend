import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../allconvertthings/getownjobs.dart';
import '../../brosepage/filterdroplist.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../myoffers/myofferscall.dart';
import 'editjobcall.dart';
import 'myjobspage.dart';
var jobtitletext;
var jobfieldtext;
var citytext;
var descriptiontext;
var jbid;
class editjob extends StatefulWidget {
  var a;
  var b;
  var c;
  var d;
  var e;
 // const editjob({Key? key}) : super(key: key);
  editjob(String jobtitletxt,String jobfieldtxt,String citytxt,String descriptiontxt,int jobid){
    this.a = jobtitletxt;
    jobtitletext=this.a;
    this.b = jobfieldtxt;
    jobfieldtext=this.b;
    this.c = citytxt;
    citytext=this.c;
    this.d = descriptiontxt;
    descriptiontext=this.d;
    this.e = jobid;
    jbid=this.e;
  }
  @override
  State<editjob> createState() => _editjobState();
}

class _editjobState extends State<editjob> {
  var formfieldjobtitle = TextEditingController(text: jobtitletext);
  var formfieldjobfield = TextEditingController(text: jobfieldtext);
  var formfieldjobcity = TextEditingController(text: citytext);
  var formfieldjobdescription = TextEditingController(text: descriptiontext);
  var formfieldjobtitlestr = "";
  var formfieldjobfieldstr = "";
  var formfieldjobcitystr = '';
  var formfieldjobdescriptionstr = "";
  final _mykey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:[TextButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),onPressed: ()async{
          EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
        await  deletejobcall(ctx: context, usertoken: Usertokenallpages, jobid: jbid);
       // await getownjobs(userNameFromToken,Usertokenallpages);
          EasyLoading.dismiss();

        }, child: Text('DeleteJob',style: TextStyle(color: Colors.red),))],
        title: Text('Edit Job',style: TextStyle(color: Colors.black),),centerTitle: true,backgroundColor: Colors.white, leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ), ),
      body: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 15, top: MediaQuery.of(context).size.height*0.15, right: 15),
          child: Form(
            key: _mykey,
            child: Column(
              children: [
                Container(
                    width:MediaQuery.of(context).size.width*0.6,
                    child:TextFormField( //autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                          label: Text('Job Title')),
                      controller: formfieldjobtitle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Job Title can\'t be empty';
                        }
                        if (value.length<3) {
                          return 'Job Title is short';
                        }
                        if (value.length>36) {
                          return 'Job Title is too long';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 15),
                Container(
                    width:MediaQuery.of(context).size.width*0.6,
                    child:TextFormField( //autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          label: Text('Job Field')),
                      controller: formfieldjobfield,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Job Field can\'t be empty';
                        }
                        if (value.length<3) {
                          return 'Job Field is short';
                        }
                        if (value.length>36) {
                          return 'Job Field is too long';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [Text('City  :',style: TextStyle(fontSize: 20),),Container(
                    width:MediaQuery.of(context).size.width*0.6,
                    child:buildcitybutton(context),
                  ),],),

                SizedBox(height: 15),
                Container(
                    width:MediaQuery.of(context).size.width*0.8,
                    child:TextFormField( //autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description can\'t be empty';
                        }
                        if (value.length>512) {
                          return 'Description is too long';
                        }
                        if (value.length < 15) {
                          return 'Description should be 15 or more';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          label: Text('Description')),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: formfieldjobdescription,
                    )),
                SizedBox(height: 15),
              ],

            ),),
        ),
      ],),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
        print(formfieldjobcitystr);
        formfieldjobtitlestr = formfieldjobtitle.text;
        formfieldjobfieldstr = formfieldjobfield.text;
        // formfieldjobcitystr = formfieldjobcity.text;
        formfieldjobdescriptionstr = formfieldjobdescription.text;
        if (_mykey.currentState!.validate() && formfieldjobcitystr!='CITY' && formfieldjobcitystr!=''&&formfieldjobcitystr!= null) {

          await savejobcall(ctx: context, usertoken: Usertokenallpages, jobid: jbid);
         // await getownjobs(userNameFromToken,Usertokenallpages);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 10),
              content: Text("Edited !"),
              duration: Duration(seconds: 2)));

          formfieldjobtitle.clear();
          formfieldjobfield.clear();
          formfieldjobcity.clear();
          formfieldjobcitystr='';
          formfieldjobdescription.clear();

          formfieldjobcitystr=listcity[0];
          dropdownValue = listcity[0];
          EasyLoading.dismiss();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 10),
              content: Text("Check your entries!"),
              duration: Duration(seconds: 2)));
          print('something wrong');
          EasyLoading.dismiss();
        }

      },backgroundColor: Colors.black,child: Text('SaveJob')),

    );
  }
 // int g=['CITY','IRBED','JERASH','AJLOUN','AMMAN','BALQAA','ZARQAA','MAFRAQ','MAAN','KARAK','AQABA','MADABA'].indexOf(citytext);
  String dropdownValue = listcity[0];
  @override
  Widget buildcitybutton(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
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
          formfieldjobcitystr=value!;
          print(formfieldjobcitystr);
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
  savejobcall({required BuildContext ctx,required String usertoken,required int jobid})async{
    final datamodelsave = await Editjobcall(
      jobName: formfieldjobtitlestr,
      field: formfieldjobfieldstr,
      city: formfieldjobcitystr,
      description: formfieldjobdescriptionstr,
    );
    //myjoboffers =[];
    var url="https://polite-puma-8.telebit.io/handywork/v1/job/${jobid}/update";
    var asdasd =editjobcallToJson(datamodelsave);
    var res= await http.patch(Uri.parse(url),
        headers: {"Authorization": "Bearer ${usertoken}","content-type": "application/json"},
        body:asdasd);
    print(res.statusCode);
    print(res.body);
    if(res.statusCode==200){
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
              content: Text(
                  "Saved "),
              duration: Duration(seconds: 3)));
      await getownjobs(userNameFromToken,Usertokenallpages);
      await getoffersonmyjob(usertoken: Usertokenallpages, username: userNameFromToken);
       int count = 0;
      EasyLoading.dismiss();
      Navigator.of(ctx).popUntil((_) => count++ >= 2);
    }
  }
}
