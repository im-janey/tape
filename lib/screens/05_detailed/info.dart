import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/05_detailed/review.dart';
import 'package:flutter_application_1/screens/05_detailed/scroll1.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 150),
                  child: Text(
                    '오뜨로 성수',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '서울특별시 성동구 뚝섬로1길 31 (성수동1가)',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Image.asset(
                  'assets/star1.png',
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _toggleFavorite,
                  icon: Icon(Icons.favorite,
                      color: _isFavorited ? Color(0xff4863E0) : Colors.grey),
                  iconSize: 27,
                ),
                Text(
                  '찜하기',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/parking1.png', width: 60),
                Image.asset('assets/wheelgo.png', width: 60),
                Image.asset('assets/usewheel.png', width: 60),
              ],
            ),
            Scroll1(),
            const TabBar(
              tabs: [
                Tab(text: '리뷰'),
                Tab(text: '정보'),
                Tab(text: '메뉴'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: const [
                  Review(),
                  Center(child: Text('탭 2의 내용')),
                  Center(child: Text('탭 3의 내용')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
