import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/05_detailed/rating.dart';

import 'package:flutter_application_1/screens/05_detailed/refunc.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/gungun.png'),
            ),
            SizedBox(
              width: 40,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Rating()));
                  },
                  child: Image.asset('assets/Rating.png')),
            ),
          ],
        ),
        Expanded(
          child: Refunc(),
        )
      ],
    );
  }
}
