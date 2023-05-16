import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:handywork0/homepagematerial/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'allconvertthings/convertjson.dart';
import 'allconvertthings/converttaken.dart';
import 'allconvertthings/jwtdecode.dart';
import 'allconvertthings/taketoken.dart';
import 'brosepage/filterdroplist.dart';
import 'main.dart';

var formfieldusername = TextEditingController();
var formfieldpassword = TextEditingController();
var formfieldfirstname = TextEditingController();
var formfieldlastname = TextEditingController();
var formfieldemail = TextEditingController();
var formfieldphonenum = TextEditingController();
var formfieldcity = TextEditingController();
var usernamestr = "";
var passwordstr = "";
var firstnamestr = "";
var lastnamestr = "";
var emailstr = "";
var phonenumstr = "";
var citystr = "";
var imgpathstr = null;
var imgpathstr64 = "";
var UserToken;

class register extends StatefulWidget {
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _mykey = GlobalKey<FormState>();

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
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 6,
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

    return Scaffold(
        body: Form(
            key: _mykey,
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          child: Text('GoBack'),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              primary: Colors.black),
                          onPressed: () {
                            formfieldusername.clear();
                            formfieldpassword.clear();
                            formfieldfirstname.clear();
                            formfieldlastname.clear();
                            formfieldemail.clear();
                            formfieldphonenum.clear();
                          //  formfieldcity.clear();
                            Navigator.of(context).pop();
                          }),
                      SizedBox(height: 80),
                      Text("SignUp",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      SizedBox(height: 30),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                              label: Text('username')),
                          controller: formfieldusername,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'username can\'t be empty';
                            }
                            if (value.length < 4) {
                              return 'username should be 4 or more';
                            }
                            if (value.length > 36) {
                              return 'username is too Long';
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
                            label: Text('password')),
                        controller: formfieldpassword,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  label: Text('firstName')),
                              controller: formfieldfirstname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'firstName can\'t be empty';
                                }
                                if (value.length < 3) {
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
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    label: Text('lastName')),
                                controller: formfieldlastname,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'lastName can\'t be empty';
                                  }
                                  if (value.length < 3) {
                                    return 'lastName should be 3 or more';
                                  }
                                  return null;
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                              label: Text('email')),
                          keyboardType: TextInputType.emailAddress,
                          controller: formfieldemail,
                          validator: (value) {
                            String pattern =
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                            if (value!.isEmpty) {
                              return 'Email can\'t be empty';
                            }
                            if (value.isNotEmpty) {
                              bool emailvalid = RegExp(pattern).hasMatch(value);
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
                        controller: formfieldphonenum,
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
                      Row(children: [Text('City  :',style: TextStyle(fontSize: 20),),Expanded(child: builddropdownbutton(context),)],),
                      // TextFormField(
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   decoration: const InputDecoration(
                      //       border: OutlineInputBorder(
                      //           borderRadius:
                      //           BorderRadius.all(Radius.circular(50))),
                      //       label: Text('City')),
                      //   controller: formfieldcity,
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.40,
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.04,
                                  child: ElevatedButton(
                                      child: Text('Upload profile picture'),
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          primary: Colors.black),
                                      onPressed: () {
                                        myAlert();
                                      })),
                              SizedBox(
                                height: 10,
                              ),
                              //if image not null show the image
                              //if image null show text
                              _image != null
                                  ? Text(
                                "Uploaded ✅",
                                style: TextStyle(fontSize: 20),
                              )
                                  : Text(
                                "No Image ❌",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.40,
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.04,
                                  child: ElevatedButton(
                                    child: Text('SignUp'),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        primary: Colors.black),
                                    onPressed: () async {
                                      _image == null
                                          ? imgpathstr64 = ""
                                          : imgpathstr64 =
                                      await imageconvert(_image.path)
                                      as String;
                                      print(imgpathstr64);
                                      if (_mykey.currentState!.validate()&&citystr!='CITY' &&citystr!='') {

                                        print('all validates are good ');
                                        posting(context);

                                      } else {
                                        print('something wrong');
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(bottom: 10),
                                            content: Text("Check your entries!"),
                                            duration: Duration(seconds: 2)));
                                      }
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            ])));
  }
  String dropdownValue = listcity[0];
  @override
  Widget builddropdownbutton(BuildContext context) {
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
          citystr=value!;
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

  void posting(BuildContext ctx) async {
    usernamestr = formfieldusername.text;
    passwordstr = formfieldpassword.text;
    firstnamestr = formfieldfirstname.text;
    lastnamestr = formfieldlastname.text;
    emailstr = formfieldemail.text;
    phonenumstr = formfieldphonenum.text;
    //citystr = formfieldcity.text;
    final datamodelsave = await Converting(
      username: usernamestr,
      password: passwordstr,
      firstName: firstnamestr,
      lastName: lastnamestr,
      email: emailstr,
      phoneNumber: phonenumstr,
      city: citystr,
      pfpFile: imgpathstr64,
    );

    var url = "https://polite-puma-8.telebit.io/handywork/v1/user/register";
    var jdata = convertingToJson(datamodelsave);
    var res = await http.post(Uri.parse(url),
        headers: {"content-type": "application/json"}, body: jdata);
    // var respconverted = await convert.jsonDecode(res.body);

    print(res.body);
    print(res.statusCode);
    // print(respconverted);

    if (res.statusCode == 400) {
      // this"" if "" checks if the user  is already sign in dataBase before and
      var _x = convertingtakenFromJson(res.body);
      print(_x.message.phoneNumber);
      if (_x.message.username == "Username Is Taken") {
        //ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            content: Text("Username Is Taken"),
            duration: Duration(seconds: 3)));
      }
      if (_x.message.email == "Email Address Is Taken") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            content: Text("Email Address Is Taken"),
            duration: Duration(seconds: 3)));
      }
      if (_x.message.phoneNumber == "Phone Number Is Taken") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
            content: Text("Phone Number Is Taken"),
            duration: Duration(seconds: 3)));
      }

      //print(_x.message.phoneNumber);  u can remove these cmnts
      //print(_x.message.email);
      //print(_x.message.username);
    } else {
      var respconvertedtoken = await convertingtokenFromJson(res.body);
      UserToken = respconvertedtoken.token;
      userNameFromToken = jwtdecode(UserToken);
      print("User name from token is :${userNameFromToken}");

      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
          content: Text("Signed up Successfully"),
          duration: Duration(seconds: 3)));
      Navigator.of(ctx).push(MaterialPageRoute(
        builder: (context) => home0(),
      ));
      formfieldusername.clear();
      formfieldpassword.clear();
      formfieldfirstname.clear();
      formfieldlastname.clear();
      formfieldemail.clear();
      formfieldphonenum.clear();
      formfieldcity.clear();
      citystr='';
    }
    //print(res.statusCode); //201 mean good and its posted
    // print(respconverted); //a respond from the API to print the json body
  }

Future<String> imageconvert(var x) async {
  String imagepath = x;
//image path, you can get it with image_picker package
  File imagefile = File(imagepath); //convert Path to File
  Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
  String base64string =
      base64.encode(imagebytes); //convert bytes to base64 string

  return base64string;
}
