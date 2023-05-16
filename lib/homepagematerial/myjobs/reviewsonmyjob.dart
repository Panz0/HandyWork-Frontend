import 'package:flutter/material.dart';
import 'package:handywork0/homepagematerial/myjobs/reviewsonmyjobcall.dart';
import 'package:handywork0/offersandreviews/reviewoffermsgpageedit.dart';

import '../../main.dart';
import '../../myoffers/myofferscall.dart';
import '../../offersandreviews/reviewoffermsgpage.dart';

class reviewsonmyjob extends StatefulWidget {
  const reviewsonmyjob({Key? key}) : super(key: key);

  @override
  State<reviewsonmyjob> createState() => _reviewsonmyjobState();
}

class _reviewsonmyjobState extends State<reviewsonmyjob> {

  bool userbool=false;
  final ScrollController _scrollController = ScrollController();
  var reviewsonmyjobpage;
  @override
  Widget build(BuildContext context) {
    ListView reviewpagelist=buildreviewsonmyjob(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Reviews',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: reviewpagelist,
    );
  }

  ListView buildreviewsonmyjob(BuildContext ctx) {
    List<Widget> w = [];
    for (int i = 0; i < myjobreviews.length; i++) {
      w.add(containerreviewsonmyjob(
        ctx: ctx,
        id: myjobreviews[i]['reviewid'],
        jobId: myjobreviews[i]['jobId'],
        jobName: myjobreviews[i]['jobName'],
        byUserUsername: myjobreviews[i]['byUserUsername'],
        byUserUsernameImageUrl: myjobreviews[i]['byUserUsernameImageUrl'],
        onUserUsername: myjobreviews[i]['onUserUsername'],
        onUserUsernameImageUrl: myjobreviews[i]['onUserUsernameImageUrl'],
        type: myjobreviews[i]['type'],
        rating: myjobreviews[i]['rating'],
        publishDate: "${myjobreviews[i]["updateDate"] !="" ?"Edited: ":""}" + "${myjobreviews[i]["updateDate"] !="" ? myjobreviews[i]["updateDate"].toString().substring(0,10):myjobreviews[i]["publishDate"]}",
        updateDate: myjobreviews[i]['updateDate'],
        reviewText: myjobreviews[i]['reviewText'],
        usersht: userbool,
      ));
      setState(() {
       userbool!=userbool;
      });
    }
    return ListView(controller: _scrollController, children: w);
  }

  containerreviewsonmyjob({
    required BuildContext ctx,
    required int id,
    required int jobId,
    required String jobName,
    required String byUserUsername,
    required String byUserUsernameImageUrl,
    required String onUserUsername,
    required String onUserUsernameImageUrl,
    required String type,
    required int rating,
    required String publishDate,
    required String updateDate,
    required String reviewText,
    required bool usersht,
  }) {
    List<Widget>stars=[];
    for(int i =1;i<=rating;i++){

     stars.add(Icon(Icons.star, color: Colors.yellow,size: 20));

    }
    if(stars.length<5){
      for(int x=stars.length;x<5;x++){
        stars.add(Icon(Icons.star_outline,color: Colors.yellow, size: 20));
      }
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white54, borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 20.0,
                    minRadius: 20.0,
                    backgroundColor: Colors.black38,
                    backgroundImage: NetworkImage(
                        usersht==false?byUserUsernameImageUrl:onUserUsernameImageUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(  usersht==false?byUserUsername:onUserUsername, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                  ),
                  byUserUsername==userNameFromToken?  IconButton(onPressed: ()async{
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ratingscreenedit(id,reviewText),
                    ));

                  }, icon: Icon(Icons.edit_note)):Text(''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.03,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: stars,
                    ),
                    Center(
                        child: Text(
                          '${publishDate}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      reviewText,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 15),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

