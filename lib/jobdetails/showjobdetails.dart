import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../allconvertthings/jobowneruserinfo.dart';
import '../brosepage/browsepage.dart';
import '../main.dart';
import 'makeoffer/makeoffer.dart';
import 'ownerofjobprofile.dart';

List<Widget> jobdetailslistimages=[];



class jobdescriptionall extends StatefulWidget {

  @override
  State<jobdescriptionall> createState() => _jobdescriptionallState();
}

class _jobdescriptionallState extends State<jobdescriptionall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Job Description',
          style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, //color: Colors.black
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: buildd,
    );
  }

}
 buildjobdetailall(
    {
      required BuildContext context,
      required String id,
      required String city,
      required String owner,
      required String field,
      required String description,
      required String publishDate,
      required String updateDate,
      required String jobName,
      required List<String> imagesUrls,
      required String firstimage,

    }
    ){
 return  Container(
   height: double.infinity,
   child: Center(
     child: Padding(
       padding: const EdgeInsets.only(top: 15),
       child: Column(
         children: [
           Container(
             height: MediaQuery.of(context).size.height * 0.25,
             child: ListView(scrollDirection: Axis.horizontal,
                 children: jobdetailslistimages
             ),
           ),
           Expanded(
             child: Container(
               margin: EdgeInsets.only(top: 10),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(40),
                       topRight: Radius.circular(40)),
                   color: Colors.grey.shade200),
               child: Padding(
                 padding: const EdgeInsets.all(15.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Expanded(
                             child: Text(
                               '${jobName}',//job title
                               style: TextStyle(
                                   fontWeight: FontWeight.bold, fontSize: 20),
                             )),
                         // Container(
                         //     padding: EdgeInsets.all(4),
                         //     width: 100,
                         //     height: 45,
                         //     decoration: BoxDecoration(
                         //         color: Colors.deepOrange,
                         //         borderRadius: BorderRadius.circular(10)),
                         //     child: Center(
                         //         child: Text(
                         //           '20#',
                         //           style: TextStyle(
                         //               fontWeight: FontWeight.bold,
                         //               color: Colors.white,
                         //               fontSize: 20),
                         //         ))),
                       ],
                     ),
                     SizedBox(height: 10),
                     Container(
                       width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.height * 0.12,
                       child: Text(
                           '${description}',
                           textAlign: TextAlign.start,
                           style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.w600,
                             color: Colors.grey,
                           )),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 5),
                       child: Container(
                         decoration: BoxDecoration(color: Colors.black87,borderRadius: BorderRadius.circular(20)),
                         width: MediaQuery.of(context).size.width*0.50,
                         height: 4,
                       ),
                     ),
                     Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             //padding: EdgeInsets.only(right:30,),
                               width: MediaQuery.of(context).size.width*0.30,
                               height: 50,
                               child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           "Job Field",
                                           style: TextStyle(
                                             color: Colors.black26,
                                             fontWeight: FontWeight.w600,
                                             fontSize: 15.0,
                                           ),
                                         ), // Text
                                         SizedBox(
                                           height: 6,
                                         ),
                                         Container(width: MediaQuery.of(context).size.width*0.3,
                                           child: Text(overflow: TextOverflow.ellipsis,maxLines: 1,
                                             "${field}",
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontWeight: FontWeight.w600,
                                               fontSize: 15.0,
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                     // Icon(Icons.lock_outline, size: 10 ,)
                                   ]) // Container
                           ),
                           Container(
                             // padding: EdgeInsets.only(left:30,),
                               width: MediaQuery.of(context).size.width*0.30,
                               height: 50,
                               child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           'Date',
                                           style: TextStyle(
                                             color: Colors.black26,
                                             fontWeight: FontWeight.w600,
                                             fontSize: 15.0,
                                           ),
                                         ), // Text
                                         SizedBox(
                                           height: 6,
                                         ),
                                         updateDate==""?
                                         Text(
                                           "${publishDate}",
                                           style: TextStyle(
                                             color: Colors.black,
                                             fontWeight: FontWeight.w600,
                                             fontSize: 15.0,
                                           ),
                                         ):
                                         Text(
                                             "${updateDate}",
                                             style: TextStyle(
                                               color: Colors.black,
                                               fontWeight: FontWeight.w600,
                                               fontSize: 15.0,
                                             )),
                                       ],
                                     ),
                                     // Icon(Icons.lock_outline, size: 10 ,)
                                   ]) // Container
                           ),
                           Container(
                             //padding: EdgeInsets.only(right:30,),
                               width: MediaQuery.of(context).size.width*0.30,
                               height: 50,
                               child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           'City',
                                           style: TextStyle(
                                             color: Colors.black26,
                                             fontWeight: FontWeight.w600,
                                             fontSize: 15.0,
                                           ),
                                         ), // Text
                                         SizedBox(
                                           height: 6,
                                         ),
                                         Text(
                                           "${city}",
                                           style: TextStyle(
                                             color: Colors.black,
                                             fontWeight: FontWeight.w600,
                                             fontSize: 15.0,
                                           ),
                                         ),
                                       ],
                                     ),
                                     // Icon(Icons.lock_outline, size: 10 ,)
                                   ]) // Container
                           ),
                         ],
                       ),
                     )
                   ],
                 ),
               ),
             ),
           ),
           Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height * 0.27,
             decoration: const BoxDecoration(
               boxShadow: [
                 BoxShadow(
                     color: Colors.black26,
                     blurRadius: 4,
                     spreadRadius: 1.5),
               ],
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(35),
                 topRight: Radius.circular(35),
               ),
             ),
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 4.0),
               child: Column(
                 mainAxisAlignment:MainAxisAlignment.start,
                 children: [
                   Container(
                     width: double.infinity,

                     decoration: BoxDecoration(
                       color: Colors.transparent,

                     ),
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 10),
                           child: InkWell(
                             onTap:() async{
                               EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
                             await  profileratings(jobownerusername, Usertokenallpages, 'listedby');
                             EasyLoading.dismiss();
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => wonerofjobprofile(),));
                             },
                             child: Container(
                               decoration: BoxDecoration(color:Colors.black87,borderRadius: BorderRadius.circular(15) ),
                               height: MediaQuery.of(context).size.width*0.30,
                               width: MediaQuery.of(context).size.width*0.90,

                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   CircleAvatar(
                                     maxRadius: 50.0,
                                     minRadius: 50.0,
                                     backgroundColor: Colors.grey,
                                     backgroundImage: NetworkImage(jobownerpic),//todo owner pic
                                   ),
                                   SizedBox(
                                     width: 40,
                                   ),
                                   Column(
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text(
                                           'Listed By',
                                           style: TextStyle(
                                               fontSize: 15,
                                               color: Colors.white)),
                                       Text('${owner}',
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontSize: 20,
                                               color: Colors.white)), // Text
                                       Row(
                                         children: [
                                           // Icon(
                                           //   Icons.star,
                                           //   color: Colors.yellowAccent,
                                           //   size: 18,
                                           // ),
                                           // Icon(
                                           //   Icons.star,
                                           //   color: Colors.yellowAccent,
                                           //   size: 18,
                                           // ),
                                           // Icon(
                                           //   Icons.star,
                                           //   color: Colors.yellowAccent,
                                           //   size: 18,
                                           // ),
                                           // Icon(
                                           //   Icons.star,
                                           //   color: Colors.yellowAccent,
                                           //   size: 18,
                                           // ),
                                           // Icon(
                                           //   Icons.star_outline,
                                           //   color: Colors.yellowAccent,
                                           //   size: 18,
                                           // ),
                                         ],
                                       )
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 5),
                   GestureDetector(
                     onTap: () async{
                    await  popupmakeoffer(context,id);
                     },
                     child: Container(
                       child: Container(
                         //                          onTap:() {
                         //                            Navigator.push(context,
                         //                                MaterialPageRoute(
                         //                                    builder: (context) => jobdescription()
                         // )
                         //                            );
                         //                          },
                         width: MediaQuery.of(context).size.width * 0.40,
                         height: 45,
                         decoration: BoxDecoration(
                           color: Colors.black87,
                          // color: Colors.green,
                           borderRadius: BorderRadius.circular(15),
                         ),
                         child: Center(

                               child: Text(
                                 'MAKE OFFER',
                                 style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600),
                               )),

                       ),
                     ),
                   ),

                 ],
               ),
             ),
             // Container
           )
         ],
       ),
     ),
   ),
 );
}

buildcontainerpicall(BuildContext context,List<String> imagesUrls){
  jobdetailslistimages.clear();
  for(int i=0;i<imagesUrls.length;i++){
    jobdetailslistimages.add(Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    width: MediaQuery.of(context).size.width * 0.80,
    height: MediaQuery.of(context).size.height * 0.25,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imagesUrls[i]),
        )),
  ));
  //  print(imagesUrls[i]);
  }
}





