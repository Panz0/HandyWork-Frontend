import 'package:flutter/material.dart';
import 'package:handywork0/allconvertthings/getalljobs.dart';
import 'package:handywork0/homepagematerial/homepage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/splashscreen.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import 'allconvertthings/getownjobs.dart';
import 'allconvertthings/jobowneruserinfo.dart';
import 'allconvertthings/jwtdecode.dart';
import 'allconvertthings/signintoken.dart';
import 'allconvertthings/taketoken.dart';
import 'allconvertthings/userinfo.dart';
import 'brosepage/browsepage.dart';
import 'homepagematerial/myjobs/myjobspage.dart';
import 'myoffers/myofferscall.dart';
import 'signup.dart';

void main() {
  runApp(splashscreen());
}
class home0 extends StatefulWidget {
  @override
  State<home0> createState() => _home0State();
}

String userNameFromToken = "";

var _formfieldusername = TextEditingController();

var _formfieldpassword = TextEditingController();

var _usernamestr = "";

var _passwordstr = "";

String _UserToken="";

String Usertokenallpages="";

var _secure = false;


class _home0State extends State<home0> {
  @override
  Widget build(BuildContext context) {
   // _formfieldusername.clear();
   // _formfieldpassword.clear();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: signin(),
      builder: EasyLoading.init(),
    );
  }
}



class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(30),
            child: ListView(
              children: [

                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: MediaQuery.of(context).size.height*0.3,
                        width: double.infinity,child:Image.asset('assets/images/handywork.png'), ),
                  SizedBox(height: 20),
                  Text("Welcome Back",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("New to this app?", style: TextStyle(fontSize: 15)),
                      SizedBox(width: 10),
                      InkWell(
                        child: Text("Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            )),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => register(),
                        )),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  TextFormField(
                      controller: _formfieldusername,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          label: Text('Username'),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))))),
                  SizedBox(height: 25),
                  // TextFormField(
                  //     controller: _formfieldpassword,
                  //     decoration: const InputDecoration(
                  //         label: Text('Password'),
                  //         border: OutlineInputBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(50))))),
                  buildpasswordfield("Password",true),
                  SizedBox(height: 15),
                  // Text('Forgot Password?',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         decoration: TextDecoration.underline)),
                  SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          child: Text('SignIn'),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)), backgroundColor: Colors.black),
                          onPressed: () async {

                            postingsignin(context);

                           // await  getownjobs(userNameFromToken,_UserToken);
                           // print("${ownedjobs[0]["imagesUrls"]}");
                           //  Navigator.of(context).push(MaterialPageRoute(
                           //      builder: (context) => homepage()));
                          })),
                  SizedBox(height: 15),
                ]),
              ],
            ))

    );

  }

  buildpasswordfield(String nameoffield, bool eye) {
    return TextFormField(
        controller: _formfieldpassword,
        obscureText: eye ? !_secure : false,
        decoration: InputDecoration(
          label: Text(nameoffield),

          prefixIcon: Icon(eye ? Icons.fingerprint : Icons.person),
          suffixIcon: eye
              ? IconButton(
              onPressed: () {
                setState(() {
                  _secure = !_secure;
                 // print(_secure);
                });
              },
              icon:
              Icon(_secure ? Icons.visibility : Icons.visibility_off))
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        ));
  }
}

void postingsignin(BuildContext ctx) async {
 EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
  _usernamestr = _formfieldusername.text;
  _passwordstr = _formfieldpassword.text;

  final datamodelsave = await Signintoken(
    username: _usernamestr,
    password: _passwordstr,
  );

  var url = "https://polite-puma-8.telebit.io/handywork/v1/authenticate";
  var jdata = signintokenToJson(datamodelsave);
  var res = await http.post(Uri.parse(url),
      headers: {"content-type": "application/json"}, body: jdata);

  print(res.body);
  print(res.statusCode);
//403 not found   404 error with one of user or pass
// انا ما حولت ال res.body فوق لانه في حالتين  بترجع  مره ال token والمره الثانيه عن الاغلاط .....ال jsonmaps   ما بتشابهو
  if (res.statusCode == 404 || res.statusCode == 403) {
    EasyLoading.dismiss();
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text("you\'r Username or password are incorrect!"),
        duration: Duration(seconds: 3)));
  } else {

    var respconvertedtoken = await convertingtokenFromJson(res.body);
    _UserToken = respconvertedtoken.token;
    userNameFromToken = jwtdecode(_UserToken);
    Usertokenallpages =_UserToken;
    print("Token is :${_UserToken}");
    print("User name is :${userNameFromToken}");
    await getalljobs(Usertokenallpages,0,"","");//token then numofpage then city then field
    await getownjobs(userNameFromToken,Usertokenallpages);
    await getoffersonmyjob(usertoken: Usertokenallpages, username: userNameFromToken);
    await getinguserinfo(userNameFromToken,Usertokenallpages);
    await profileratings(userNameFromToken, Usertokenallpages, 'my');
    EasyLoading.dismiss();
    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text("Welcome Back"), duration: Duration(seconds: 3)));
    Navigator.of(ctx).push(MaterialPageRoute(
      builder: (context) => const homepage(),
    ));

  }
}
