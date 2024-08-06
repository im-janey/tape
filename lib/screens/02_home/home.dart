import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/02_home/banner1.dart';
import 'package:flutter_application_1/screens/02_menu/menu.dart';
import 'package:flutter_application_1/screens/04_map/map.dart';

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
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Menu()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 35,
              ),
            ),
          ],
          flexibleSpace: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
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
                              MaterialPageRoute(builder: (context) => Map()));
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Map()));
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Map()));
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: _selectedIndex == 0
                    ? Colors.grey.shade300
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? Colors.black : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Icon(
                  Icons.home,
                  size: 40,
                ),
              ),
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: _selectedIndex == 1
                    ? Colors.grey.shade300
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? Colors.black : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Icon(
                  Icons.menu,
                  size: 40,
                ),
              ),
            ),
            label: '메뉴',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
