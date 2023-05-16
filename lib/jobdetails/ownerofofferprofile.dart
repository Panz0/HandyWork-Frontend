import 'package:flutter/material.dart';

import '../allconvertthings/jobowneruserinfo.dart';
import '../main.dart';
import '../profile/infocomp.dart';
import '../ratingspage/aslister/ratingspageaslisterofferedby.dart';
import '../ratingspage/astaker/ratingspageastakerofferedby.dart';
import '../ratingspage/ratingspagecall.dart';

class ownerofofferprofile extends StatefulWidget {
  const ownerofofferprofile({Key? key}) : super(key: key);

  @override
  State<ownerofofferprofile> createState() => _ownerofofferprofileState();
}

class _ownerofofferprofileState extends State<ownerofofferprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Offered By',//todo owner profile
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
                      backgroundImage: NetworkImage(jobownerpic2),//todo owner pfp
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(jobownerusername2, //اطبع ال user name هون //todo username
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)), // Text
                        Row(children: [ Text(firstName2, // اطبع ال  first +last name
                            style: TextStyle(
                                fontSize: 15, color: Colors.white)),
                          SizedBox(width: 5),
                          Text(lastName2, // اطبع ال  first +last name
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white)),],),
                        // Text
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await ratingspageasbothcall(jobownerusername2, Usertokenallpages, 'offeredby', 'USER_REVIEW');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ratingspageaslisterofferedby(),));
                        },
                      child: Column(
                        children: [
                          Text("As job Lister",style: TextStyle(color: Colors.white),),
                          Row(children: asListerstarsofferedby),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async{
                        await ratingspageasbothcall(jobownerusername2, Usertokenallpages, 'offeredby', 'JOB_REVIEW');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ratingspageastakerofferedby(),));
                      },
                      child: Column(
                        children: [
                          Text("As job Taker",style: TextStyle(color: Colors.white),),
                          Row(children: asProfessionalofferedby),
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
                  infoComponent(title: 'Phone Number', value: phoneNumber2),
                  infoComponent(title: 'City', value: city2),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(width: MediaQuery.of(context).size.width,
                      child: infoComponent(title: 'Email', value: email2))
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
        ],
      ),
    );
  }
}
