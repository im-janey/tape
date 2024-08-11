import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteButton extends StatefulWidget {
  final String storeId;

  const FavoriteButton({super.key, required this.storeId});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;
  final FavoriteService _favoriteService = FavoriteService();
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  void _toggleFavorite() async {
    if (userId == null) return;
    setState(() {
      _isFavorited = !_isFavorited;
    });
    try {
      if (_isFavorited) {
        await _favoriteService.addFavorite(userId!, widget.storeId);
      } else {
        await _favoriteService.removeFavorite(userId!, widget.storeId);
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: Icon(
        Icons.favorite,
        color: _isFavorited ? const Color(0xff4863E0) : Colors.grey,
      ),
      iconSize: 27,
    );
  }
}

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFavorite(String userId, String storeId) async {
    await _firestore.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayUnion([storeId]),
    });
  }

  Future<List<String>> getFavorites(String userId) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userId).get();
    List<dynamic> favorites = doc.get('favorites') ?? [];
    return List<String>.from(favorites);
  }

  Future<void> removeFavorite(String userId, String storeId) async {
    await _firestore.collection('users').doc(userId).update({
      'favorites': FieldValue.arrayRemove([storeId]),
    });
  }
}

class FavoriteStoresPage extends StatelessWidget {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  FavoriteStoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('즐겨찾기')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          }

          List<String> favoriteStoreIds =
              List<String>.from(snapshot.data?.get('favorites') ?? []);

          if (favoriteStoreIds.isEmpty) {
            return const Center(child: Text('즐겨찾기한 가게가 없습니다.'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('store')
                .where(FieldPath.documentId, whereIn: favoriteStoreIds)
                .snapshots(),
            builder: (context, storeSnapshot) {
              if (storeSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (storeSnapshot.hasError) {
                return Center(
                    child: Text('오류가 발생했습니다: ${storeSnapshot.error}'));
              }

              List<DocumentSnapshot> stores = storeSnapshot.data?.docs ?? [];

              return ListView.builder(
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  var store = stores[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(
                        store['intro_image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(store['name']),
                      subtitle: Text(store['subname']),
                      trailing: FavoriteButton(storeId: store.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
