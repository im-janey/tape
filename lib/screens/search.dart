import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(height: 180),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '스타벅스',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // 검색 버튼 클릭 시 동작
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Text('취소'),
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ],
          )),
    );
  }
}
