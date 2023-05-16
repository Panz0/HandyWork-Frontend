import 'package:flutter/material.dart';
import 'package:handywork0/offersandreviews/deleteoffercall.dart';

import '../homepagematerial/myjobs/reviewsonmyjob.dart';
import '../homepagematerial/myjobs/reviewsonmyjobcall.dart';
import '../main.dart';
import '../offersandreviews/reviewoffermsgpage.dart';
import 'myofferscall.dart';

class myoffers extends StatefulWidget {
  const myoffers({Key? key}) : super(key: key);

  @override
  State<myoffers> createState() => _myoffersState();
}

class _myoffersState extends State<myoffers> {
  final ScrollController _scrollController = ScrollController();
  var offerspage;

  @override
  Widget build(BuildContext context) {
    offerspage = buildoffers(context);
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: ()async{
          await getoffersonmyjob(usertoken: Usertokenallpages, username: userNameFromToken);
          offerspage= await buildoffers(context);
          setState(() {
            offerspage=buildoffers(context);
          });
        }, icon: Icon(Icons.refresh))
      ],
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Job Offers',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(child: RefreshIndicator(
        child:offerspage,
        onRefresh: () async{
          await getoffersonmyjob(usertoken: Usertokenallpages, username: userNameFromToken);
          setState(() {
            offerspage=buildoffers(context);
          });
        },
      ),),
    );
  }

  ListView buildoffers(BuildContext ctx) {
    List<Widget> w = [];
    for (int i = 0; i < myofferslist.length; i++) {
      w.add(containeroffersonmyjob(
        ctx: ctx,
        offerid: myofferslist[i]['offerid'],
        jobTitle: myofferslist[i]['jobTitle'],
        jobId: myofferslist[i]['jobId'],
        jobImageUrl: myofferslist[i]['jobImageUrl'],
        user: myofferslist[i]['user'],
        userImageUrl: myofferslist[i]['userImageUrl'],
        suggestedAmount: myofferslist[i]['suggestedAmount'],
        accepted: myofferslist[i]['accepted'],
        rejected: myofferslist[i]['rejected'],
      ));
    }
    return ListView(controller: _scrollController, children: w);
  }

  containeroffersonmyjob({
    required BuildContext ctx,
    required int offerid,
    required String jobTitle,
    required int jobId,
    required String jobImageUrl,
    required String user,
    required String userImageUrl,
    required int suggestedAmount,
    required bool accepted,
    required bool rejected,
  }) {
    // bool enable=false;
    String Pend = 'pending';
    Widget pendwidget = Text(
      Pend,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black12),
    );
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1.5),
            ]),
        width: MediaQuery.of(ctx).size.width,
        height: MediaQuery.of(ctx).size.height * 0.30,
        child: Column(
          children: [
            GestureDetector(
              onTap: accepted == true? () async {
                await  getreviewsnmyjob(usertoken: Usertokenallpages, jobid: jobId);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  reviewsonmyjob(),));
               // await anyuserprofile2(
                  // user, Usertokenallpages); // todo go to review list
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ownerofofferprofile(),
                // ));
              }:null,
              child: Container(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 50),
                      child: CircleAvatar(
                        maxRadius: 25.0,
                        minRadius: 25.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(jobImageUrl),
                      ),
                    ),
                    Text(
                      '${jobTitle}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Offer Ammount:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${suggestedAmount}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 10,
              ),
              child: Row(
                children: [
                  Text(
                    'Statues:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  accepted == false && rejected == false
                      ? pendwidget
                      : accepted == true
                      ? Text('Accepted',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.green))
                      : rejected == true
                      ? Text('Rejected',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.red))
                      : Text('')
                ],
              ),
            ),
            Expanded(
                child: Row(
                  children: [SizedBox(height: MediaQuery.of(ctx).size.height)],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: MediaQuery.of(ctx).size.width * 0.22,
                     // child: ElevatedButton(
                      //     onPressed: accepted == false && rejected == false
                      //         ? () async {
                      //       // var st = await patchaccept(
                      //       //     offerid, Usertokenallpages);
                      //       // if (st == 200) {
                      //       //   await getoffersonmyjob(
                      //       //       jobid: jobId,
                      //       //       usertoken: Usertokenallpages);
                      //       //   ScaffoldMessenger.of(ctx).showSnackBar(
                      //       //       const SnackBar(
                      //       //           content: Text(
                      //       //               "You Have Accepted this offer"),
                      //       //           duration: Duration(seconds: 3)));
                      //       //   Navigator.of(context).pop();
                      //       // }
                      //     }
                      //         : null,
                      //     child: Text('Accept'),
                      //     style: ButtonStyle(
                      //         backgroundColor:
                      //         MaterialStateProperty.all(Colors.green)))
                  ),

                  Container(
                      width: MediaQuery.of(ctx).size.width * 0.22,
                      child: ElevatedButton(
                          onPressed: accepted == false && rejected == false
                              ? () async {
                                await deleteoffercall(ctx: ctx, usertoken: Usertokenallpages, offerid: offerid);
                                await getoffersonmyjob(usertoken: Usertokenallpages, username: userNameFromToken);
                                setState(() {
                                  offerspage=buildoffers(context);
                                });
                               // offerspage=buildoffers(context);
                            // var st = await patchreject(
                            //     offerid, Usertokenallpages);
                            // if (st == 200) {
                            //   setState(() {
                            //     Pend = "Rejected";
                            //   });
                            //   ScaffoldMessenger.of(ctx).showSnackBar(
                            //       const SnackBar(
                            //           content: Text(
                            //               "You Have Declined the offer"),
                            //           duration: Duration(seconds: 3)));
                            //   Navigator.of(context).pop();
                            // }
                          }
                              : null,
                          child: Text('Delete'),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.red)))),

                  Container(
                      width: MediaQuery.of(ctx).size.width * 0.22,
                      child: ElevatedButton(
                          onPressed: accepted == true
                              ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ratingscreen(jobId),
                            )); //todo  new call api
                          }
                              : null,
                          child: Text(
                            'Review',
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.black26)))),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
