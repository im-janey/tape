import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/info.dart';

class Favorite extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('찜')),
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

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('찜한 가게가 없습니다.'));
          }

          Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;
          List<String> categories = [
            'restaurant',
            'cafe',
            'park',
            'display',
            'play'
          ];
          List<String> favoriteStoreIds = [];

          for (var category in categories) {
            if (userData[category] != null) {
              favoriteStoreIds.addAll(List<String>.from(userData[category]));
            }
          }

          if (favoriteStoreIds.isEmpty) {
            return const Center(child: Text('찜한 가게가 없습니다.'));
          }

          return FutureBuilder<List<DocumentSnapshot>>(
            future: _fetchFavoriteStores(favoriteStoreIds),
            builder: (context, storeSnapshot) {
              if (storeSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (storeSnapshot.hasError) {
                return Center(
                    child: Text('오류가 발생했습니다: ${storeSnapshot.error}'));
              }

              List<DocumentSnapshot> stores = storeSnapshot.data ?? [];

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
                      trailing: IconButton(
                        icon: const Icon(Icons.favorite,
                            color: Color(0xff4863E0)),
                        onPressed: () => _removeFavorite(
                            context, store.id, store.reference.parent.id),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Info(
                              storeId: store.id,
                              collectionName: store.reference.parent.id),
                        ),
                      ),
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

  Future<List<DocumentSnapshot>> _fetchFavoriteStores(
      List<String> storeIds) async {
    List<String> categories = ['restaurant', 'cafe', 'park', 'display', 'play'];
    List<DocumentSnapshot> allStores = [];

    for (var category in categories) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection(category)
          .where(FieldPath.documentId, whereIn: storeIds)
          .get();
      allStores.addAll(querySnapshot.docs);
    }

    return allStores;
  }

  void _removeFavorite(
      BuildContext context, String storeId, String collectionName) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        collectionName: FieldValue.arrayRemove([storeId]),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('즐겨찾기에서 제거되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생했습니다: $e')),
      );
    }
  }
}
