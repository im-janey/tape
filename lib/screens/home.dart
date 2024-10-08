import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/navigation_bar.dart';
import 'package:flutter_application_1/screens/map/cafe.dart';
import 'package:flutter_application_1/screens/map/frame.dart';
import 'package:flutter_application_1/screens/map/park.dart';
import 'package:flutter_application_1/screens/menu.dart';
import 'package:flutter_application_1/screens/banner1.dart';
import 'package:flutter_application_1/screens/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => index == 0 ? Home() : Menu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 17, 17, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Search()));
                },
                icon: Icon(
                  Icons.search,
                  size: 33,
                ),
              ),
            ),
          ],
          flexibleSpace: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                ),
                SizedBox(
                  width: 200,
                  height: 100,
                  child: Image.asset('assets/firstlogo.png'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Banner1(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Frame()));
                        },
                        child: SizedBox(
                            height: 60,
                            width: 50,
                            child: Image.asset('assets/bob.png'))),
                    TextButton(
                        onPressed: () {},
                        child: SizedBox(
                            height: 60,
                            width: 50,
                            child: Image.asset('assets/display.png'))),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CafeFrame()));
                        },
                        child: SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.asset('assets/cafe1.png'))),
                    TextButton(
                        onPressed: () {},
                        child: SizedBox(
                            height: 70,
                            width: 60,
                            child: Image.asset('assets/play.png'))),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParkFrame()));
                        },
                        child: SizedBox(
                            height: 70,
                            width: 40,
                            child: Image.asset('assets/park.png'))),
                    TextButton(
                        onPressed: () {},
                        child: SizedBox(
                            height: 60,
                            width: 50,
                            child: Image.asset('assets/all.png'))),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
