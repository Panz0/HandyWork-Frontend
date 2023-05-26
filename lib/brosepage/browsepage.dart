import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/jobdetails/showjobdetails.dart';
import '../allconvertthings/getalljobs.dart';
import '../allconvertthings/getownjobs.dart';
import '../allconvertthings/jobowneruserinfo.dart';
import '../homepagematerial/homepage.dart';
import '../main.dart';
import '../profile/myprofile.dart';
import 'filterdroplist.dart';

int minimum =-1;
int initialvalueforloop=0;
int browsepages=0;
var buildd;
class Browsepage extends StatefulWidget {
  const Browsepage({super.key});

  @override
  State<Browsepage> createState() => _navigationbarHome();
}
var ownjoblist;
class _navigationbarHome extends State<Browsepage> {

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    ListView browsepageJobs=buildallJobs(context,numberofalljobs);
     filterby(BuildContext ctx) async{

       filteredcity='';
       filteredfield='';
       dropdownfinalfilter='';
      showDialog(
          useSafeArea: true,
         context: ctx,
         //useRootNavigator: true,

          builder: (BuildContext ctx1) {
            return  AlertDialog(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                title: Text('Filter By'),
                content: Container(
                  height: MediaQuery.of(ctx1).size.height / 5.5,
                  width: MediaQuery.of(ctx1).size.width,
                  child: Column(
                    children: [
                      Row(children: [
                       Text("City:  "),
                        DropdownButtonCity(),
                      //   Expanded(child: Container(width: MediaQuery.of(ctx).size.width*0.25,
                      //     child: Autocomplete(
                      //       optionsBuilder: (textEditingValue) {
                      //         if(textEditingValue.text == ''){
                      //           return const Iterable<String>.empty();
                      //         }
                      //         filteredcity=textEditingValue.text;
                      //         return listcity.where((String element) =>element.contains(textEditingValue.text));
                      //
                      //       },)
                      // ),),
                        ],),
                      SizedBox(height: 4),
                      Row(children: [
                        Text("Field: "),
                        Container(width: MediaQuery.of(ctx1).size.width*0.17,
                          child: Autocomplete(
                            optionsBuilder: (textEditingValue) {
                              if(textEditingValue.text == ''){
                                return const Iterable<String>.empty();
                              }
                              filteredfield=textEditingValue.text;
                              return listfield.where((String element) =>element.contains(textEditingValue.text));

                            },),
                        ),
                      ],),
                      SizedBox(height: 5),
                     Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         ElevatedButton(onPressed: ()async{

                           filteredcity='';
                           print(filteredfield);
                           filteredfield='';
                           await getalljobs(Usertokenallpages,0,filteredcity,filteredfield);
                           setState((){
                             browsepages=0;
                             browsepageJobs=buildallJobs(context,numberofalljobs);
                             print(listcity);
                           });
                           // Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => homepage(),));
                           Navigator.pop(ctx1);
                           //Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (context) => const homepage()));
                         },
                             child: Text('Reset'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),

                       ElevatedButton(onPressed: ()async{

                         print('eljowab el final is ${dropdownfinalfilter}');
                         if(dropdownfinalfilter!='CITY'){
                           filteredcity=dropdownfinalfilter;
                         }else{
                           filteredcity='';
                           print(filteredcity);
                         }
                         print(filteredcity);
                         print(filteredfield);
                         if(filteredfield==null){filteredfield='';}
                         await getalljobs(Usertokenallpages,0,filteredcity,filteredfield);
                        //filteredcity='';
                        // filteredfield='';
                         setState((){
                           browsepages=0;
                           browsepageJobs=buildallJobs(context,numberofalljobs);
                           print(listcity);
                         });
                         Navigator.pop(ctx1);

                        // Navigator.of(ctx1).pushReplacement(MaterialPageRoute(builder: (context) => homepage(),));
                       },
                           child: Text('Save'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),


                     ],)

                    ],
                  ),
                ),
            );
          });
    }



    return Scaffold(
      appBar: AppBar(title: Row(
          children: [
           Expanded(child:  Text("Browse jobs",style: TextStyle(color: Colors.black),),flex: 4),
            ElevatedButton(onPressed: ()async{

             await filterby(context);
            // await getalljobs(Usertokenallpages,0,filteredcity,filteredfield);
              setState((){
                browsepages=0;
                browsepageJobs=buildallJobs(context,numberofalljobs);
                print(listcity);
              });
             filteredcity='';
             filteredfield='';
            },
                child:Text("Filter"),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))),

          ]),

          backgroundColor: Colors.white),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: Container(child: RefreshIndicator(
              child:browsepageJobs,
              onRefresh: () async{
                await getalljobs(Usertokenallpages,0,"","");
                setState(() {
                 filteredcity='';
                 filteredfield='';
                  browsepages=0;
                  browsepageJobs=buildallJobs(context,numberofalljobs);
                });
              },
            ),
            padding: EdgeInsets.only( top: 20),


              // ElevatedButton(onPressed: (){}, child: Text('Nextpage'))

          )
      ),
    );

  }



  ListView buildallJobs(BuildContext ctx,int numofjobs){
    List<Widget> w=[];
    for(int i=0;i<numofjobs;i++) {
      w.add(containerbuilder2all(
          id:"${alljobs[i]["id"]}",
          owner: "${alljobs[i]["owner"]}",
          city: "${alljobs[i]["city"]}",
          imagesUrls:alljobs[i]["imagesUrls"],
          updateDate: "${alljobs[i]["updateDate"]}",
          ctx: ctx,
          description: "${alljobs[i]["description"]}",
          field: "${alljobs[i]["field"]}",
          firstimage: "${alljobs[i]["imagesUrls"][0]}",
          jobName: "${alljobs[i]["jobName"]}",
          publishDate: "${alljobs[i]["updateDate"] !="" ?"Edited: ":""}" + "${alljobs[i]["updateDate"] !="" ? alljobs[i]["updateDate"]:alljobs[i]["publishDate"]}"));
    }
    w.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(ctx).size.width*0.4,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)), backgroundColor: Colors.black),
                child: Text("Previous"),onPressed: ()async{
              EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
              if(browsepages != 0){
                browsepages =browsepages-1;
                if(filteredcity==null){filteredcity='';}
                if(filteredfield==null){filteredfield='';}
                await  getalljobs(Usertokenallpages,browsepages,filteredcity,filteredfield);
                setState(() {
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn);
                  });
                  buildallJobs(context,numberofalljobs);
                });
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(bottom: 10),
                    content: Text("You are at Page 1"),
                    duration: Duration(seconds: 2)));
              }
            EasyLoading.dismiss();
            }), ),
          Container(
            width: MediaQuery.of(ctx).size.width*0.4,
            child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)), backgroundColor: Colors.black),
                child: Text("Next"),onPressed: ()async{
              EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
             if(browsepages<allpagesnum-1) {
                browsepages = browsepages + 1;
                if(filteredcity==null){filteredcity='';}
                if(filteredfield==null){filteredfield='';}
                await getalljobs(Usertokenallpages, browsepages,filteredcity,filteredfield);
                setState(() {

                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                        _scrollController.position.minScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.fastOutSlowIn);
                  });
                  buildallJobs(context, numberofalljobs);
                  print(browsepages);
                  print(allpagesnum-1);
                });
              }else{
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(behavior: SnackBarBehavior.floating,
                   margin: EdgeInsets.only(bottom: 10),
                   content: Text("You are at Last Page"),
                   duration: Duration(seconds: 2)));
             }
              EasyLoading.dismiss();
            }),
          )]));
    w.add(SizedBox(height: 35,));
    return ListView(controller: _scrollController,children:w);
  }
}



containerbuilder2all({
  required BuildContext ctx,
  required String id,
  required String owner,
  required String city,
  required String field,
  required String description,
  required String publishDate,
  required String updateDate,
  required String jobName,
  required List<String> imagesUrls,
  required String firstimage,

}) {
  return InkWell(
    onTap:() async{
      EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
      await anyuserprofile(owner,Usertokenallpages);
      await  buildcontainerpicall(ctx,imagesUrls);
      buildd= await buildjobdetailall(context: ctx,id: id,owner: owner,field: field,description: description,city: city,publishDate: publishDate,updateDate: updateDate,jobName: jobName,imagesUrls: imagesUrls,firstimage: firstimage);
      EasyLoading.dismiss();
      Navigator.of(ctx).push(MaterialPageRoute( builder: (context) =>  jobdescriptionall()));
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
                      child: Text('${description}',style: TextStyle(fontSize: 13,),
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
                    Text('By: ${owner}'),//todo add username ownerusername
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
  //       border: Border.all(color: Colors.black),
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
  //               await getuserpic(owner,Usertokenallpages);
  //             await  buildcontainerpicall(ctx,imagesUrls);
  //             buildd= await buildjobdetailall(context: ctx,id: id,owner: owner,field: field,description: description,city: city,publishDate: publishDate,updateDate: updateDate,jobName: jobName,imagesUrls: imagesUrls,firstimage: firstimage);
  //               Navigator.of(ctx).push(MaterialPageRoute( builder: (context) =>  jobdescriptionall()));
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
  //                              Text('By: ${owner}'),//todo add username ownerusername
  //                            Text("${publishDate}"),
  //                           ]),
  //                     ))
  //               ],
  //             ))),
  //     SizedBox(width: 15),
  //     Expanded(
  //       flex: 9,
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

