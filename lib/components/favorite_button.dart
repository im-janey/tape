import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final String category; // 카테고리
  final String name; // 이름

  const FavoriteButton({super.key, required this.category, required this.name});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  void _checkIfFavorited() {
    // Implement your logic to check if the item is favorited
    // For example, you can fetch the favorite status from a database
  }

  void _toggleFavorite() async {
    setState(() {
      _isFavorited = !_isFavorited;
    });

    // Implement your logic to update the favorite status in the database
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: Icon(
        Icons.favorite,
        color: _isFavorited ? Color(0xff4863E0) : Colors.grey,
      ),
      iconSize: 27,
    );
  }
}