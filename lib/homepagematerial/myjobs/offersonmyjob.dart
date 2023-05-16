import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/jobdetails/ownerofofferprofile.dart';
import 'package:handywork0/offersandreviews/reviewoffermsgpage.dart';
import 'package:http/http.dart' as http;
import '../../allconvertthings/jobowneruserinfo.dart';
import '../../jobdetails/ownerofjobprofile.dart';
import '../../main.dart';
import 'offersonmyjobcall.dart';

class offersonmyjob extends StatefulWidget {
  const offersonmyjob({Key? key}) : super(key: key);

  @override
  State<offersonmyjob> createState() => _offersonmyjobState();
}

class _offersonmyjobState extends State<offersonmyjob> {
  final ScrollController _scrollController = ScrollController();
  var offersonmyjobpage;

  @override
  Widget build(BuildContext context) {
    offersonmyjobpage = buildoffersonmyjob(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Job Offers',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(child: offersonmyjobpage),
    );
  }

  ListView buildoffersonmyjob(BuildContext ctx) {
    List<Widget> w = [];
    for (int i = 0; i < myjoboffers.length; i++) {
      w.add(containeroffersonmyjob(
        ctx: ctx,
        offerid: myjoboffers[i]['offerid'],
        jobTitle: myjoboffers[i]['jobTitle'],
        jobId: myjoboffers[i]['jobId'],
        jobImageUrl: myjoboffers[i]['jobImageUrl'],
        user: myjoboffers[i]['user'],
        userImageUrl: myjoboffers[i]['userImageUrl'],
        suggestedAmount: myjoboffers[i]['suggestedAmount'],
        accepted: myjoboffers[i]['accepted'],
        rejected: myjoboffers[i]['rejected'],
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
              onTap: () async {
                EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
                await anyuserprofile2(
                    user, Usertokenallpages); // todo change it to any user 2
                await profileratings(user, Usertokenallpages, 'offeredby');
                EasyLoading.dismiss();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ownerofofferprofile(),
                ));
              },
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
                        backgroundImage: NetworkImage(userImageUrl),
                      ),
                    ),
                    Text(
                      '${user}',
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
                      child: ElevatedButton(
                          onPressed: accepted == false && rejected == false
                              ? () async {
                                  var st = await patchaccept(
                                      offerid, Usertokenallpages);
                                  if (st == 200) {
                                    await getoffersonmyjob(
                                        jobid: jobId,
                                        usertoken: Usertokenallpages);
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "You Have Accepted this offer"),
                                            duration: Duration(seconds: 3)));
                                    Navigator.of(context).pop();
                                  }
                                }
                              : null,
                          child: Text('Accept'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)))),

                  Container(
                      width: MediaQuery.of(ctx).size.width * 0.22,
                      child: ElevatedButton(
                          onPressed: accepted == false && rejected == false
                              ? () async {
                                  var st = await patchreject(
                                      offerid, Usertokenallpages);
                                  if (st == 200) {
                                    setState(() {
                                      Pend = "Rejected";
                                    });
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "You Have Declined the offer"),
                                            duration: Duration(seconds: 3)));
                                    Navigator.of(context).pop();
                                  }
                                }
                              : null,
                          child: Text('Decline'),
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

                  // InkWell(
                  //
                  //   onTap: null
                  //     // Navigator.push(context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) =>itemlispage()
                  //     //     )
                  //     // );
                  //   ,
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.22,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         color: Colors.green.shade600,
                  //         borderRadius: BorderRadius.circular(7),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.grey,
                  //               blurRadius: 2,
                  //               spreadRadius: 1.5),
                  //         ]),
                  //     child: Center(
                  //         child: Text('Accept',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w500))),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.push(context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) =>itemlispage()
                  //     //     )
                  //     // );
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.22,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         color: Colors.red.shade600,
                  //         borderRadius: BorderRadius.circular(7),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.grey,
                  //               blurRadius: 2,
                  //               spreadRadius: 1.5),
                  //         ]),
                  //     child: Center(
                  //         child: Text('Decline',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.w500))),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.push(context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) =>itemlispage()
                  //     //     )
                  //     // );
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width * 0.22,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black87,
                  //         borderRadius: BorderRadius.circular(7),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.grey,
                  //               blurRadius: 2,
                  //               spreadRadius: 1.5),
                  //         ]),
                  //     child: Center(
                  //         child: Text(
                  //       'Review',
                  //       style: TextStyle(
                  //           color: Colors.white, fontWeight: FontWeight.w500),
                  //     )),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

patchaccept(int offerid, String usertoken) async {
  var url =
      "https://polite-puma-8.telebit.io/handywork/v1/offer/${offerid}/accept";
  var res = await http.patch(Uri.parse(url), headers: {
    "Authorization": "Bearer ${usertoken}",
    "content-type": "application/json"
  });
  print(res.statusCode);
  return res.statusCode as int;
}

patchreject(int offerid, String usertoken) async {
  var url =
      "https://polite-puma-8.telebit.io/handywork/v1/offer/${offerid}/reject";
  var res = await http.patch(Uri.parse(url), headers: {
    "Authorization": "Bearer ${usertoken}",
    "content-type": "application/json"
  });
  print(res.statusCode);
  return res.statusCode as int;
}
