import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/course/folder.dart';

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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          onTap: widget.onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 40,
                color:
                    widget.selectedIndex == 0 ? Color(0xff4863E0) : Colors.grey,
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                size: 40,
                color:
                    widget.selectedIndex == 1 ? Color(0xff4863E0) : Colors.grey,
              ),
              label: '메뉴',
            ),
          ],
        ),
        Positioned(
          bottom: 50,
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
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
