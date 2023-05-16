import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:handywork0/homepagematerial/myjobs/editjob.dart';
import 'package:handywork0/homepagematerial/myjobs/reviewsonmyjob.dart';
import 'package:handywork0/homepagematerial/myjobs/reviewsonmyjobcall.dart';

import '../../main.dart';
import 'offersonmyjob.dart';
import 'offersonmyjobcall.dart';
import 'myjobspage.dart';


List<Widget> jobdetailslistimages=[];


var jobtitletext;
var jobfieldtext;
var citytext;
var descriptiontext;
var jobidint;
var editlogo;
class jobdescriptionmy extends StatefulWidget {
  var a;
  jobdescriptionmy(bool done){
    this.a=done;
    editlogo=this.a;
  }
  @override
  State<jobdescriptionmy> createState() => _jobdescriptionmyState();
}

class _jobdescriptionmyState extends State<jobdescriptionmy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(actions: [editlogo==false||editlogo==null?IconButton(onPressed: ()async{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => editjob(jobtitletext,jobfieldtext,citytext,descriptiontext,jobidint)));
      },icon: Icon(Icons.edit_note_outlined)):IconButton(onPressed: (){
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 15),
            content: Text("You'r Job is Done,You Can't Edit it"), duration: Duration(seconds: 2)));
      }, icon: Icon(Icons.edit_off))],
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
      body: buildm,
    );
  }

}
buildjobdetail(
    {
      required BuildContext context,
      required int id,
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
   jobtitletext=jobName;
   jobfieldtext=field;
   citytext=city;
   descriptiontext=description;
   jobidint=id;
  return  Container(
    height: double.infinity,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
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
                     SizedBox(height:MediaQuery.of(context).size.height*0.15),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black87,borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width*0.50,
                          height: 4,
                        ),
                      ),
                      Container(
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
              height: MediaQuery.of(context).size.height * 0.12,
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
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [

                    Center(
                      child: InkWell(onTap: () async{
                        EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
                      await  getoffersonmyjob(jobid:id ,usertoken: Usertokenallpages);
                      EasyLoading.dismiss();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => offersonmyjob(),));
                      },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text(
                                'OFFERS',
                                style: TextStyle(color: Colors.white,fontWeight:FontWeight.w600),
                              )),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(onTap: () async{
                        EasyLoading.show( maskType: EasyLoadingMaskType.black,status: "Loading ...");
                      await  getreviewsnmyjob(usertoken: Usertokenallpages, jobid: id);
                      EasyLoading.dismiss();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  reviewsonmyjob(),));
                      },
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text(
                                'REVIEWS',
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

buildcontainerpic(BuildContext context,List<String> imagesUrls){
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
