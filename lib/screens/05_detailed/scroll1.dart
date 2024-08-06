import 'package:flutter/material.dart';

class Scroll1 extends StatelessWidget {
  const Scroll1({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          SizedBox(
            width: 50,
          ),
          Container(
              height: 200,
              width: 340,
              // 카드 스크롤의 높이를 설정
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset('assets/san1.png')),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset('assets/san2.png')),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset('assets/san3.png')),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset('assets/san4.png')),
                ),
              ])),
        ],
      ),
    );
  }
}
