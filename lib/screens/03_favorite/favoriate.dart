import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('찜'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Option(
            imageUrl: 'assets/fav1.png',
            name: '오뜨로 성수',
          ),
          Option(
            imageUrl: 'assets/fav2.png',
            name: '차이나플레인',
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String imageUrl;
  final String name;
  Option({super.key, required this.imageUrl, required this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: 150, height: 150),
        Icon(Icons.favorite, color: Color(0xff4863E0)),
        Text(name, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
