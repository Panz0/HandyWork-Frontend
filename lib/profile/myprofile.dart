import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/profile/updateprofile.dart';
import 'package:handywork0/ratingspage/aslister/ratingspageaslistermy.dart';
import 'package:handywork0/ratingspage/ratingspagecall.dart';
import 'package:http/http.dart' as http;
import 'package:restart_app/restart_app.dart';
import '../allconvertthings/jobowneruserinfo.dart';
import '../allconvertthings/signintoken.dart';
import '../allconvertthings/userinfo.dart';
import '../main.dart';
import '../ratingspage/astaker/ratingspageastakermy.dart';
import '../splashscreen.dart';
import 'infocomp.dart';


var _passwordcheckcontroller = TextEditingController();
var authstatscode;
var pic = myprofileuserinfo["pfpUrl"];
var fname=  myprofileuserinfo['firstName'];
var lname=  myprofileuserinfo['lastName'];
var phone= myprofileuserinfo['phoneNumber'];
var city= myprofileuserinfo['city'];
var email= myprofileuserinfo['email'];

class Myprofile extends StatefulWidget {
  const Myprofile({Key? key}) : super(key: key);

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {


  _showPasswordDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return ScaffoldMessenger(
              child: Builder(builder:(context) {
              return  Scaffold(
                body: AlertDialog(
                  title: Text('Authenticate'),
                  content: TextFormField(
                    //not sure if i need this
                    controller: _passwordcheckcontroller,
                    decoration: InputDecoration(hintText: 'Enter Password'),
                    maxLength: 36,
                    obscureText: true,

                  ),
                  actions: [
                    ElevatedButton(
                      child: Text('Check'),
                      onPressed: ()async{
                        await Editauth(context);
                        if ( authstatscode == 404 ||authstatscode == 403) {

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("incorrect password!"),
                              duration: Duration(seconds: 3)));
                        }else{
                          _passwordcheckcontroller.clear();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => updateinfo()),);
                        }
                      },
                    ),
                  ],
                ),
              );

          }, ));
            

        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            userNameFromToken='';
            Usertokenallpages='';
           await Restart.restartApp();
          }, icon: Icon(Icons.logout)),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(35),
                bottomLeft: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 50.0,
                      minRadius: 50.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(pic),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(myprofileuserinfo["username"], //اطبع ال user name هون
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)), // Text
                       Row(children: [ Text(fname, // اطبع ال  first +last name
                           style: TextStyle(
                               fontSize: 15, color: Colors.white)),
                         SizedBox(width: 5),
                         Text(lname, // اطبع ال  first +last name
                             style: TextStyle(
                                 fontSize: 15, color: Colors.white)),],),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
                        await ratingspageasbothcall(userNameFromToken, Usertokenallpages, 'my', 'USER_REVIEW');
                        EasyLoading.dismiss();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ratingspageaslistermy(),));
                      },
                      child: Column(
                        children: [
                          Text("As job Lister",style: TextStyle(color: Colors.white),),
                          Row(children: asListerstarsmy),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
                        await ratingspageasbothcall(userNameFromToken, Usertokenallpages, 'my', 'JOB_REVIEW');
                        EasyLoading.dismiss();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ratingspageastakermy(),));
                      },
                      child: Column(
                        children: [
                          Text("As job Taker",style: TextStyle(color: Colors.white),),
                          Row(children: asProfessionalmy),
                        ],
                      ),
                    )
                  ],)
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Row(
                children: [
                  infoComponent(title: 'Phone Number', value: phone),
                  infoComponent(title: 'City', value: city),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(width: MediaQuery.of(context).size.width,
                    child: infoComponent(title: 'Email', value: email),)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          InkWell(
            child: Container(
              child: Center(
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            onTap: () {
              _showPasswordDialog();
             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => updateinfo()),);
            },
          )
        ],
      ),
    );
  }
}





Editauth(BuildContext ctx) async {

 var _passwordstr = _passwordcheckcontroller.text;

  final datamodelsave = await Signintoken(
    username: userNameFromToken,
    password: _passwordstr,
  );

  var url = "https://polite-puma-8.telebit.io/handywork/v1/authenticate";
  var jdata = signintokenToJson(datamodelsave);
  var res = await http.post(Uri.parse(url),
      headers: {"content-type": "application/json"}, body: jdata);

  print(res.body);
 return authstatscode =res.statusCode;

}

