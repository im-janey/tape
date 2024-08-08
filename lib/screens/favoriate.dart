import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/favorite_button.dart';

class Favorite extends StatelessWidget {
  final String userId;

  const Favorite({super.key, required this.userId});

  Future<List<Map<String, dynamic>>> getFavoriteStores(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('찜'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Option(
                imageUrl: 'assets/fav1.png',
                name: '오뜨로 성수',
                category: '식당',
              ),
              Option(
                imageUrl: 'assets/fav2.png',
                name: '차이나플레인',
                category: '식당',
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getFavoriteStores(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No favorite stores found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var store = snapshot.data![index];
                      return ListTile(
                        title: Text(store['name']),
                        subtitle: Text(store['category']),
                        onTap: () {
                          // 구글맵 위치로 이동하는 코드 추가 가능
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String category;

  const Option({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(imageUrl, width: 150, height: 150),
            Positioned(
              bottom: 3,
              right: 3,
              child: FavoriteButton(category: category, name: name),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontSize: 20, color: Colors.black)),
            Text(category, style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
