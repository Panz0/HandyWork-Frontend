
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/brosepage/browsepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../allconvertthings/getownjobs.dart';
import '../brosepage/filterdroplist.dart';
import '../homepagematerial/homepage.dart';
import '../homepagematerial/myjobs/myjobspage.dart';
import '../main.dart';
import 'convert/addjobconvert.dart';
import 'package:http/http.dart' as http;


var dropdownfinaladdjob;
class addjob extends StatefulWidget {
  const addjob({Key? key}) : super(key: key);


  @override
  State<addjob> createState() => _addjobState();
}

List<String> listofimages64=[];
class _addjobState extends State<addjob> {
  var formfieldjobtitle = TextEditingController();
  var formfieldjobfield = TextEditingController();
  var formfieldjobcity = TextEditingController();
  var formfieldjobdescription = TextEditingController();
  var formfieldjobtitlestr = "";
  var formfieldjobfieldstr = "";
  var formfieldjobcitystr = "";
  var formfieldjobdescriptionstr = "";
  final _mykey = GlobalKey<FormState>();

  var _images=[];
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource media) async {
    _images.clear();
    listofimages64.clear();
    final  List<XFile>? listofimages =await _picker.pickMultiImage();
    if(listofimages!.isNotEmpty){
      print(listofimages);
      if(listofimages.length==1){
        listofimages64.add((await imageconvert(listofimages[0].path)));
      }else{
        if(listofimages.length==2){
          listofimages64.add((await imageconvert(listofimages[0].path)));
          listofimages64.add((await imageconvert(listofimages[1].path)));
        }else{
          for(int i=0;i<listofimages.length;i++){
            _images.add(listofimages[i]);
          }
          for(int i=0;i<_images.length;i++){
            listofimages64.add((await imageconvert(listofimages[i].path)));
          }
        }
      }
    }



    setState(() {
    });
print(listofimages64);
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.black),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> imageconvert(var x) async {
    String imagepath = x;
//image path, you can get it with image_picker package
    File imagefile = File(imagepath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string =
    base64.encode(imagebytes); //convert bytes to base64 string
    //print("OOOOOOOOOOOOOOOOOOO");
    return base64string;

  }

  @override
  Widget build(BuildContext context) {
    // formfieldjobcitystr=listcity[0];
    // dropdownValue = listcity[0];
    return Scaffold(
      appBar: AppBar(title: Text('Add Request'),centerTitle: true,backgroundColor: Colors.black),
      body: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 15, top: MediaQuery.of(context).size.height*0.15, right: 15),
          child: buildAddJobForm(context),
        ),
      ],),
      floatingActionButton: buildFloatingButtonAdd(context),
    );
  }

  Form buildAddJobForm(BuildContext context) {
    return Form(
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)), backgroundColor: Colors.black),
                  onPressed: () =>myAlert() , child: Text('Upload Photos')),
              Text("Maximum 5 photos",style: TextStyle(color: Colors.red),),
            ],

          ),);
  }

   buildFloatingButtonAdd(BuildContext context) {
    return Container(
      height: 70.0,
      width: 70.0,
      child: FittedBox(
        child: FloatingActionButton(onPressed: () async{
          EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
          print(formfieldjobcitystr);
          formfieldjobtitlestr = formfieldjobtitle.text;
          formfieldjobfieldstr = formfieldjobfield.text;
          // formfieldjobcitystr = formfieldjobcity.text;
          formfieldjobdescriptionstr = formfieldjobdescription.text;
          if (_mykey.currentState!.validate() && formfieldjobcitystr!='CITY' && formfieldjobcitystr!='') {
            print('all validates are good ');
            await adding();
            await getownjobs(userNameFromToken,Usertokenallpages);
            // myjobslist=await buildMyJobs(context,myjobslength);
            setState(() {
              myjobslist=buildMyJobs(context,myjobslength);
              // PersistentNavBarNavigator.pushNewScreen(
              //   context,
              //   screen: myjobspage(),
              //   withNavBar: true, // OPTIONAL VALUE. True by default.
              //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
              // );
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 10),
                content: Text("You Have Listed a Job!"),
                duration: Duration(seconds: 2)));

            formfieldjobtitle.clear();
            formfieldjobfield.clear();
            formfieldjobcity.clear();
            formfieldjobcitystr='';
            formfieldjobdescription.clear();
            listofimages64.clear();
            _images.clear();
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

        },backgroundColor: Colors.black,child: Text('Add\nRequest',style: TextStyle(fontSize: 10),)),
      ),
    );
    return FloatingActionButton(onPressed: () async{
      EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
      print(formfieldjobcitystr);
      formfieldjobtitlestr = formfieldjobtitle.text;
      formfieldjobfieldstr = formfieldjobfield.text;
     // formfieldjobcitystr = formfieldjobcity.text;
      formfieldjobdescriptionstr = formfieldjobdescription.text;
      if (_mykey.currentState!.validate() && formfieldjobcitystr!='CITY' && formfieldjobcitystr!='') {
        print('all validates are good ');
        await adding();
        await getownjobs(userNameFromToken,Usertokenallpages);
       // myjobslist=await buildMyJobs(context,myjobslength);
        setState(() {
          myjobslist=buildMyJobs(context,myjobslength);
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: myjobspage(),
          //   withNavBar: true, // OPTIONAL VALUE. True by default.
          //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          // );
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 10),
            content: Text("You Have Listed a Job!"),
            duration: Duration(seconds: 2)));

        formfieldjobtitle.clear();
        formfieldjobfield.clear();
        formfieldjobcity.clear();
        formfieldjobcitystr='';
        formfieldjobdescription.clear();
        listofimages64.clear();
        _images.clear();
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

    },backgroundColor: Colors.black,child: Text('Add\nRequest'));
  }
  adding()async{
    final datamodelsave = await Addjobconvert(
      jobName: formfieldjobtitlestr,
      field: formfieldjobfieldstr,
      city: formfieldjobcitystr,
      description: formfieldjobdescriptionstr,
      imagesFiles: listofimages64,
    );

    final _jdata = addjobconvertToJson(datamodelsave);
    var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${userNameFromToken}/job/save";
    var res = await http.post(Uri.parse(url),
        body: _jdata,
        headers: {
          "Authorization": "Bearer ${Usertokenallpages}",
          "content-type": "application/json"
        });
    print(res.statusCode);
    print(res.body);
  }

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

