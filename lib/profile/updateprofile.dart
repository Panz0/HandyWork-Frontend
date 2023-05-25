
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/profile/updateconverts/updatefirst.dart';
import 'package:handywork0/profile/updateconverts/updatepasswordconvert.dart';
import 'package:handywork0/profile/updateconverts/updatepfpfileconvert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../allconvertthings/updatefirsthalfjson.dart';
import '../allconvertthings/userinfo.dart';
import '../brosepage/filterdroplist.dart';
import '../homepagematerial/homepage.dart';
import '../main.dart';
import '../signup.dart';
import 'myprofile.dart';

// var formfieldupdatepassword1 = TextEditingController();
// var formfieldupdatepassword2 = TextEditingController();
var formfieldupdatefirstname = TextEditingController();
var formfieldupdatelastname = TextEditingController();
var formfieldupdateemail = TextEditingController();
var formfieldupdatephonenum = TextEditingController();
var formfieldupdatecity = TextEditingController();
var updatepasswordstr1 = "";
var updatepasswordstr2 = "";
var updatefirstnamestr = "";
var updatelastnamestr = "";
var updateemailstr = "";
var updatephonenumstr = "";
var updatecitystr = "";
var imgpathstr64= "";
var updatepic = pic;
var dropdownfinalupdateprof;

bool isButtonDisabled=true ;


class updateinfo extends StatefulWidget {
  const updateinfo({Key? key}) : super(key: key);

  @override
  State<updateinfo> createState() => _updateinfoState();
}

class _updateinfoState extends State<updateinfo> {
  final _mykey = GlobalKey<FormState>();

  var formfieldupdatepassword1 = TextEditingController();
  var formfieldupdatepassword2 = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    formfieldupdatefirstname.text = myprofileuserinfo['firstName'];
    formfieldupdatelastname.text = myprofileuserinfo['lastName'];
    formfieldupdateemail.text = myprofileuserinfo['email'];
    formfieldupdatephonenum.text = myprofileuserinfo['phoneNumber'];
    formfieldupdatecity.text = myprofileuserinfo['city'];
  }

  ////////////////////////////////////////////pic file
  var _image;

  final ImagePicker _picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await _picker.pickImage(source: media);

    setState(() {
      _image = img;
    });
  }

  //show popup dialog    for  image  take
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.black),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
   // dropdownfinalupdateprof=listcity[0];
    // dropdownValue = listcity[0];
    return  Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Update Profile Information',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () async{
              await getinguserinfo(userNameFromToken,Usertokenallpages);
              setState(() {
                 pic = myprofileuserinfo["pfpUrl"];
                 fname=  myprofileuserinfo['firstName'];
                 lname=  myprofileuserinfo['lastName'];
                 phone= myprofileuserinfo['phoneNumber'];
                 city= myprofileuserinfo['city'];
                 email= myprofileuserinfo['email'];
              });

              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => homepage()));
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 15, top: 35, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: InkWell(
                    onTap: (){
                      myAlert();
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                 image: NetworkImage(updatepic),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 3, color: Colors.white),
                                color: _image==null?Colors.black:Colors.green),
                            child: Icon(
                             _image != null? Icons.check :Icons.create,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                    key: _mykey,
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: ElevatedButton(

                                  child: Text('Update'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      backgroundColor: Colors.black),
                                  onPressed: () async{
                                  if(_image != null){
                                    imgpathstr64 = await imageconvert(_image.path);
                                    await  updatepfp(context,Usertokenallpages,userNameFromToken);
                                    setState(() {
                                      pic = myprofileuserinfo['pfpUrl'];
                                    });
                                  }
                                  }),
                            ),
                          ],
                        ),

                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    label: Text('firstName')),
                                controller: formfieldupdatefirstname,
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return 'firstName should be 3 or more';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      label: Text('lastName')),
                                  controller: formfieldupdatelastname,
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return 'lastName should be 3 or more';
                                    }
                                    return null;
                                  }),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                label: Text('email')),
                            keyboardType: TextInputType.emailAddress,
                            controller: formfieldupdateemail,
                            validator: (value) {
                              String pattern =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              if (value!.isEmpty) {
                                return 'Email can\'t be empty';
                              }
                              if (value.isNotEmpty) {
                                bool emailvalid =
                                    RegExp(pattern).hasMatch(value);
                                return emailvalid ? null : "Invalid Email";
                              }
                              return null;
                            }),
                        SizedBox(height: 15),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              label: Text('phoneNumber')),
                          keyboardType: TextInputType.phone,
                          controller: formfieldupdatephonenum,
                          validator: (value) {
                            String pattern =
                                r"^07[789][0-9]{7}$"; //jordan phones validation
                            if (value!.isEmpty) {
                              return 'phoneNumber can\'t be empty';
                            }
                            if (value.isNotEmpty) {
                              bool phonevalid = RegExp(pattern).hasMatch(value);
                              return phonevalid ? null : "Invalid phoneNumber";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),

                        // Container(
                        //     width: MediaQuery.of(context).size.width*0.4,
                        //     child: builddropdownbutton(context)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [Text('City  :',style: TextStyle(fontSize: 20),),Container(
                            width:MediaQuery.of(context).size.width*0.6,
                            child:builddropdownbutton(context),
                          ),],),
                        // TextFormField(
                        //   autovalidateMode: AutovalidateMode.onUserInteraction,
                        //   decoration: const InputDecoration(
                        //       border: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(50))),
                        //       label: Text('City')),
                        //   controller: formfieldupdatecity,
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'City can\'t be empty';
                        //     }
                        //     if (value.length < 3) {
                        //       return 'City should be 3 or more';
                        //     }
                        //     return null;
                        //   },
                        // ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  child: Text('Update'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    if (_mykey.currentState!.validate()&&dropdownfinalupdateprof!='CITY' &&dropdownfinalupdateprof!=''&&dropdownfinalupdateprof!= null) {
                                      print('all validates are good ');
                                      updatefirsthalf(
                                          context, Usertokenallpages,userNameFromToken);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(bottom: 10),
                                          content: Text("Check your entries!"),
                                          duration: Duration(seconds: 2)));
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 15),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text('password')),
                  controller: formfieldupdatepassword1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    if (value.length < 8) {
                      return 'Password should be 8 or more';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      label: Text('Confirm password')),
                  controller: formfieldupdatepassword2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password can\'t be empty';
                    }
                    if (value.length < 8) {
                      return 'Password should be 8 or more';
                    }
                    return null;
                  },
                ),
                 SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                          child: Text('Change Password'),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.black),
                          onPressed: () {
                            updatepasswordstr1=formfieldupdatepassword1.text;
                            updatepasswordstr2=formfieldupdatepassword2.text;
                            if(updatepasswordstr1==updatepasswordstr2){
                              updatepassword(context, Usertokenallpages, userNameFromToken);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(bottom: 10),
                                  content: Text("Updated!"),
                                  duration: Duration(seconds: 4)));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(bottom: 10),
                                  content: Text("Check your Entries!"),
                                  duration: Duration(seconds: 4)));
                            }

                          }),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
    );

  }

  String dropdownValue = listcity[0];

  @override
  Widget builddropdownbutton(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      isExpanded: true,
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
          dropdownfinalupdateprof =value!;
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
updatepfp(BuildContext ctx , String token,String username) async{
  final _datamodelsave = UpdatepfpFile(
    pfpFile: imgpathstr64,
  );
  print(_datamodelsave.pfpFile);
  final _jdata = updatepfpFileToJson(_datamodelsave);
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/update/pfpUrl";
  var res = await http.patch(Uri.parse(url),
      body: _jdata,
      headers: {
        "Authorization": "Bearer ${token}",
        "content-type": "application/json"
      });
   updatepic =res.body.toString();
}

void updatefirsthalf(BuildContext ctx, String token,String username) async {
  // if(dropdownfinalupdateprof!='CITY' &&dropdownfinalupdateprof!=''){
  //   dropdownfinalupdateprof='AMMAN';
  // }
  updatefirstnamestr = formfieldupdatefirstname.text;
  updatelastnamestr = formfieldupdatelastname.text;
  updateemailstr = formfieldupdateemail.text;
  updatephonenumstr = formfieldupdatephonenum.text;
 // updatecitystr = formfieldupdatecity.text;

  final _datamodelsave = Updatefirst(
    firstName: updatefirstnamestr,
    lastName: updatelastnamestr,
    email: updateemailstr,
    phoneNumber: updatephonenumstr,
    city: dropdownfinalupdateprof,
  );
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/update/main";
  final _jdata = updatefirstToJson(_datamodelsave);
  var res = await http.patch(Uri.parse(url),
      body: _jdata,
      headers: {
        "Authorization": "Bearer ${token}",
        "content-type": "application/json"
      });
  print(res.statusCode);
  print(res.body);


  if (res.statusCode == 400) {
    var _s = updatefirsthalfJsonFromJson(res.body);
    print(_s.message.email);
    print(_s.message.phoneNumber);
    // this"" if "" checks if the user  is already sign in dataBase before and
    if (_s.message.email == "Email Address Is Taken") {

      ScaffoldMessenger.of(ctx).showSnackBar( SnackBar( behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 10),
          content: Text("Email Address Is Taken"), duration: Duration(seconds: 4)));
    }
    if (_s.message.phoneNumber == "Phone Number Is Taken") {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 10),
          content: Text("Phone Number Is Taken"), duration: Duration(seconds: 4)));
    }
  }else{
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 10),
        content: Text("Updated!"),
        duration: Duration(seconds: 4)));
  }
}

updatepassword(BuildContext ctx, String token,String username) async{
  final _datamodelsave = Updatepassword(
   password:updatepasswordstr1,
  );
  final _jdata = updatepasswordToJson(_datamodelsave);
  var url = "https://polite-puma-8.telebit.io/handywork/v1/user/${username}/update/password";
  var res = await http.patch(Uri.parse(url),
      body: _jdata ,
      headers: {
        "Authorization": "Bearer ${token}",
        "content-type": "application/json"
      });
  print(res.body);
}
