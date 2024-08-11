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

          List<String> favoriteStoreIds = [];
          if (snapshot.data != null && snapshot.data!.exists) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            favoriteStoreIds = [
              ...List<String>.from(data['restaurant'] ?? []),
              ...List<String>.from(data['cafe'] ?? []),
              ...List<String>.from(data['park'] ?? []),
              ...List<String>.from(data['display'] ?? []),
              ...List<String>.from(data['play'] ?? []),
            ];
          }

          if (favoriteStoreIds.isEmpty) {
            return const Center(child: Text('찜한 가게가 없습니다.'));
          }

          return StreamBuilder<List<DocumentSnapshot>>(
            stream: _fetchFavoriteStoresStream(favoriteStoreIds),
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

  Stream<List<DocumentSnapshot>> _fetchFavoriteStoresStream(
      List<String> storeIds) {
    List<String> collections = [
      'restaurant',
      'cafe',
      'park',
      'display',
      'play'
    ];

    return Stream.fromFuture(Future.wait(collections.map((collection) {
      return FirebaseFirestore.instance
          .collection(collection)
          .where(FieldPath.documentId,
              whereIn: storeIds.isNotEmpty ? storeIds : [''])
          .get();
    }))).map((querySnapshots) {
      return querySnapshots.expand((qs) => qs.docs).toList();
    });
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
