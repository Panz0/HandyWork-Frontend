import 'package:flutter/material.dart';
import 'package:handywork0/homepagematerial/myjobs/myjobspage.dart';
import 'package:handywork0/homepagematerial/settingstile.dart';

import '../allconvertthings/getownjobs.dart';
import '../main.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settings();
}

class _settings extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              GestureDetector(child: settingstile(title: "profile",color: Colors.black,icon: Icons.person,),onTap: (){},),
              SizedBox(height: 20,),
              GestureDetector(child: settingstile(title: "myJobs",color: Colors.black,icon: Icons.handyman,),onTap: ()async{
                await getownjobs(userNameFromToken,Usertokenallpages);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const myjobspage(),
                ));
              },),
              SizedBox(height: 20),
              GestureDetector(child: settingstile(title: "About",color: Colors.black,icon: Icons.question_mark,),onTap: (){},),
              SizedBox(height: 20),
              GestureDetector(child: settingstile(title: "Logout",color: Colors.black,icon: Icons.login_outlined,),onTap: (){},),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}