import 'package:flutter/material.dart';

class infoComponent extends StatelessWidget {
  const infoComponent({Key? key, required this.title, required this.value}) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left:30,),
        width: MediaQuery.of(context).size.width / 2,
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
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
                    value,
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
    );
  }
}