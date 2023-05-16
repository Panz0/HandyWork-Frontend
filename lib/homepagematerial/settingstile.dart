import 'package:flutter/material.dart';

class settingstile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  const settingstile({Key? key, required this.color, required this.icon, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 20),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(Icons.chevron_right_outlined),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}