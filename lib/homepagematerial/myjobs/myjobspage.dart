import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/homepagematerial/myjobs/showjobdetailsmy.dart';
import 'package:handywork0/jobdetails/showjobdetails.dart';

import '../../allconvertthings/getownjobs.dart';
import '../../allconvertthings/jobowneruserinfo.dart';
import '../../main.dart';



int minimum =-1;
int initialvalueforloop=0;
var buildm;
var myjobslist;
class myjobspage extends StatefulWidget {
  const myjobspage({Key? key}) : super(key: key);

  @override
  State<myjobspage> createState() => _myjobspageState();
}

class _myjobspageState extends State<myjobspage> {
  @override
  Widget build(BuildContext context) {
     myjobslist =buildMyJobs(context,myjobslength);
    return Scaffold(

      body:Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Container(
             padding: EdgeInsets.only( top: 30),

            child:  RefreshIndicator(onRefresh: () async{
               await getownjobs(userNameFromToken,Usertokenallpages);
              setState(() {
                myjobslist=buildMyJobs(context,myjobslength);
              });
            },
            child: myjobslist),
          )
      ),
    );
  }
}

containerbuilder2my({
 // required int imageslength,

  required int id,
  required String owner,
  required String doneBy,
  required String field,
  required String description,
  required String publishDate,
  required String updateDate,
  required String jobName,
  required List<String> imagesUrls,
  required bool done,
  required String city,
  required BuildContext ctx,
  required String firstimage,
}) {
  return InkWell(
  onTap:() async{
  //  await getuserpic(userNameFromToken,Usertokenallpages);
    EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
    await  buildcontainerpic(ctx,imagesUrls);
    buildm= await buildjobdetail(context: ctx,id: id,owner: owner,field: field,description: description,city: city,publishDate: publishDate,updateDate: updateDate,jobName: jobName,imagesUrls: imagesUrls,firstimage: firstimage);
   EasyLoading.dismiss();
    Navigator.of(ctx).push(MaterialPageRoute( builder: (context) =>  jobdescriptionmy(done)));
  },
  child: Container(

    margin: EdgeInsets.all(10),
    width: MediaQuery.of(ctx).size.width,
    height: MediaQuery.of(ctx).size.height*0.15,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(

      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(ctx).size.width * 0.35,
            height: MediaQuery.of(ctx).size.height ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      '${firstimage}'),
                )),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(

              children: [
                Container(
                  //  width:MediaQuery.of(ctx).size.width * 0.55,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(width: MediaQuery.of(ctx).size.width * 0.5,
                        child: Text('${jobName}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                ),
              ],),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(

                children: [
                  Container(
                    width:MediaQuery.of(ctx).size.width * 0.50,
                    height: MediaQuery.of(ctx).size.height * 0.05,
                    child: Text('${description}',style: TextStyle(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                  ),
                ],),
            ),
            Container(
              // margin: const EdgeInsets.only(bottom: 5),
              width:MediaQuery.of(ctx).size.width * 0.50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(width: MediaQuery.of(ctx).size.width * 0.15,
                      child: Text('${city}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black38),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('|',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,),),
                  Container(width: MediaQuery.of(ctx).size.width * 0.15,
                      child: Text('${field}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black38),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('|',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,)),
                  Container(width: MediaQuery.of(ctx).size.width * 0.15,
                      child: Text('${publishDate}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black38),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            Expanded(
              child: Row(children: [
                SizedBox(height: MediaQuery.of(ctx).size.height,),
              ]),
            ),
            Container(
              width: MediaQuery.of(ctx).size.width * 0.50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Job Statues: ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black),),
                  //  Text('Completed'),
                  // Icon(Icons.check_circle_outline,color: Colors.green,),

                  done==false? Text('Incomplete',style: TextStyle(color: Colors.black38)):Text('Completed',style: TextStyle(color: Colors.black38)),
                  //                             Text("${publishDate}"),
                  done==false?Icon(Icons.not_interested,color: Colors.red):Icon(Icons.check,color: Colors.green),

                ],),
            ),
            Row(

                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(ctx).size.width * 0.55,
                    height: 1,
                    decoration: BoxDecoration(color: Colors.black38),)
                ],
              ),
          ],
        )
      ],
    ),

  ),
);

  // return Container(
  //   decoration: BoxDecoration(
  //       color: Colors.black12,
  //       border: Border.all(color: done==false ? Colors.yellow.shade600:Colors.green,width: 2),
  //       borderRadius: BorderRadius.circular(0)),
  //   margin: EdgeInsets.only(top: 10, bottom: 10, left: 4, right: 4),
  //   width: MediaQuery.of(ctx).size.width,
  //   height: MediaQuery.of(ctx).size.height / 5.8,
  //   child: Row(children: [
  //
  //     SizedBox(width: 10),
  //     Flexible(
  //         flex: 13,
  //         child: InkWell(
  //             onTap: () async{
  //               await getuserpic(userNameFromToken,Usertokenallpages);
  //               await  buildcontainerpic(ctx,imagesUrls);
  //               buildm= await buildjobdetail(context: ctx,id: id,owner: owner,field: field,description: description,city: city,publishDate: publishDate,updateDate: updateDate,jobName: jobName,imagesUrls: imagesUrls,firstimage: firstimage);
  //               Navigator.of(ctx).push(MaterialPageRoute( builder: (context) =>  jobdescriptionmy()));
  //             },
  //             child: Column(
  //               children: [
  //                 Flexible(
  //                     flex: 2,
  //                     child: Container(
  //                       alignment: Alignment.topLeft,
  //                       child: Text(
  //                         '${jobName}',
  //                         style: TextStyle(fontSize: 22),
  //                       ),
  //                     )),
  //                 Flexible(
  //                     flex: 1,
  //                     child: Container(
  //                       alignment: Alignment.topLeft,
  //                       child: Text(
  //                         '${field}',
  //                         style: TextStyle(fontSize: 15),
  //                       ),
  //                     )),
  //                 SizedBox(height: 8),
  //                 Flexible(
  //                   flex: 3,
  //                   child: Container(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       '${description}',
  //                       style: TextStyle(fontSize: 12),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 15),
  //                 Flexible(
  //                     flex: 2,
  //                     child: Container(
  //                       height: 80,
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //                             done==false? Text('🟡 incomplete'):Text('🟢 completd'),
  //                             Text("${publishDate}"),
  //                           ]),
  //                     ))
  //               ],
  //             ))),
  //     SizedBox(width: 15),
  //     Expanded(
  //       flex: 10,
  //       child: Container(
  //         decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.circular(22)),
  //         child: Image.network(
  //           '${firstimage}',
  //           fit: BoxFit.cover,
  //         ),
  //         width: MediaQuery.of(ctx).size.width,
  //         height: MediaQuery.of(ctx).size.height,
  //         // color: Colors.amber,
  //       ),
  //     )
  //   ]),
  // );
}



ListView buildMyJobs(BuildContext ctx,int numofjobs){
  List<Widget> w=[];
  for(int i=0;i<numofjobs;i++) {
    w.add(containerbuilder2my(
      //imageslength:"${ownedjobs[i]["imagesUrls"].length}",////////changed it today
        id: ownedjobs[i]["id"],
        city: "${ownedjobs[i]["city"]}",
        doneBy: "${ownedjobs[i]["doneBy"]}",
        imagesUrls: ownedjobs[i]["imagesUrls"],
        owner: "${ownedjobs[i]["owner"]}",
        updateDate: "${ownedjobs[i]["updateDate"]}",
        ctx: ctx,
        description: "${ownedjobs[i]["description"]}",
        field: "${ownedjobs[i]["field"]}",
        firstimage: "${ownedjobs[i]["imagesUrls"][0]}",
        jobName: "${ownedjobs[i]["jobName"]}",
        done: ownedjobs[i]["done"],
        publishDate: "${ownedjobs[i]["publishDate"]}")) ;
  }
  return ListView(children:w);
}