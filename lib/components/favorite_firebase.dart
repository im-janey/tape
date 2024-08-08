import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFavorite(String userId, String category, String name,
      Map<String, dynamic> details) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .add({
      'category': category,
      'name': name,
    });
  }

  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> removeFavorite(String userId, String favoriteId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(favoriteId)
        .delete();
  }
}
