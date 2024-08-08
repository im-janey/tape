import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/course/folder.dart';
import 'package:flutter_application_1/screens/menu.dart';
import '../screens/home.dart';

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => index == 0 ? Home() : Menu()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home, size: 40),
                color: _selectedIndex == 0 ? Color(0xff4863E0) : Colors.grey,
                onPressed: () => _onItemTapped(0),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.menu, size: 40),
                color: _selectedIndex == 1 ? Color(0xff4863E0) : Colors.grey,
                onPressed: () => _onItemTapped(1),
              ),
              label: '메뉴',
            ),
          ],
        ),
        Positioned(
          bottom: 59,
          left: MediaQuery.of(context).size.width / 2 - 28,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Folder()),
              );
            },
            backgroundColor: Color(0xff4863E0),
            foregroundColor: Colors.white,
            shape: CircleBorder(),
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
