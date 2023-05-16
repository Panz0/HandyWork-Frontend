import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handywork0/offersandreviews/reviewoffermsgpagecall.dart';

import '../main.dart';

var jobid;
class ratingscreen extends StatefulWidget {
  //const ratingscreen({Key? key}) : super(key: key);
  var x;
  ratingscreen(int jbid) {
    // See initializing formal parameters for a better way
    // to initialize instance variables.
    this.x = jbid;
    jobid=this.x;
  }
  @override
  State<ratingscreen> createState() => _ratingscreenState();
}

class _ratingscreenState extends State<ratingscreen> {
  final _mykey = GlobalKey<FormState>();
  int reviewwhoofferedthisrate = 1;
  var formfieltext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Review',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _mykey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 2, spreadRadius: 1.5),
                ]),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                      colors: [
                        Colors.black,
                        Colors.grey,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, blurRadius: 5, spreadRadius: 5),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, left: 10, right: 20),
                          child: Text(
                            'Rate the User',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: TextFormField(controller: formfieltext,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Its can\'t be empty';
                              }
                              if (value.length < 15) {
                                return 'should be 15 or more';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                label: Center(
                                    child: Text('Rate the User as you feel.'))),
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: reviewwhoofferedthisrate.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                      //  print(rating);
                        reviewwhoofferedthisrate = rating.toInt();
                        print(reviewwhoofferedthisrate);
                      },
                    )
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(onPressed: ()async{
                    if (_mykey.currentState!.validate()){
                      print(reviewwhoofferedthisrate);
                      sendreviewoffer(ctx: context,usertoken: Usertokenallpages, jobid: jobid, rating: reviewwhoofferedthisrate, reviewtext: formfieltext.text);
                    }

                  }, child: Text('Submit'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black54)),)
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
