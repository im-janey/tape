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
          RestaurantOption(
            imageUrl: 'assets/bob.png',
            name: '오뚜르 성수',
          ),
          RestaurantOption(
            imageUrl: 'assets/cafe1.png',
            name: '차이나플레인',
          ),
        ],
      ),
    );
  }
}

class RestaurantOption extends StatelessWidget {
  final String imageUrl;
  final String name;
  RestaurantOption({required this.imageUrl, required this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageUrl, width: 150, height: 150),
        Icon(Icons.favorite, color: Colors.blue),
        Text(name, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
