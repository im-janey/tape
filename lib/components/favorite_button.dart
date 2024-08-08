import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // firebase에서 userId 가져오기

// 사용자 데이터를 표시하는 Stateless 위젯
class UserData extends StatelessWidget {
  final String userId;

  // userId를 초기화하는 생성자
  UserData({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      // Firestore에서 사용자 데이터 가져오기
      future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
      builder: (context, snapshot) {
        // 데이터를 기다리는 동안 로딩 인디케이터 표시
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // 사용자 데이터를 추출하여 표시
        var userData = snapshot.data!.data() as Map<String, dynamic>;
        return Center(child: Text('User data: ${userData.toString()}'));
      },
    );
  }
}

// 즐겨찾기 버튼을 위한 Stateful 위젯
class FavoriteButton extends StatefulWidget {
  final String name;

  // name을 초기화하는 생성자
  const FavoriteButton({super.key, required this.name});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorited = false;
  final FavoriteService _favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  // 항목이 이미 즐겨찾기에 있는지 확인
  void _checkIfFavorited() async {
    try {
      // 'userId'를 사용하여 사용자의 즐겨찾기 목록을 가져옴
      var favorites = await _favoriteService.getFavorites('userId');
      // 상태 업데이트 및 해당 가게가 찜 목록에 있는지 확인
      setState(() {
        _isFavorited = favorites.any((fav) => fav['name'] == widget.name);
      });
    } catch (e) {
      // 에러 메시지를 콘솔에 출력
      print('Error checking favorite status: $e');
    }
  }

  // 즐겨찾기 상태를 토글
  void _toggleFavorite() async {
    setState(() {
      _isFavorited = !_isFavorited;
    });

    try {
      if (_isFavorited) {
        // 즐겨찾기에 추가
        await _favoriteService.addFavorite(
            FirebaseAuth.instance.currentUser?.uid as String, widget.name, {});
      } else {
        // 즐겨찾기에서 제거
        var favorites = await _favoriteService.getFavorites('userId');
        var favorite =
            favorites.firstWhere((fav) => fav['name'] == widget.name);
        await _favoriteService.removeFavorite('userId', favorite['id']);
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
        color: _isFavorited ? Color(0xff4863E0) : Colors.grey,
      ),
      iconSize: 27,
    );
  }
}

// 즐겨찾기 작업을 처리하는 서비스 클래스
class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firestore에 즐겨찾기 항목 추가
  Future<void> addFavorite(
      String userId, String name, Map<String, dynamic> details) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .add({
      'name': name,
    });
  }

  // Firestore에서 즐겨찾기 항목 목록 가져오기
  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    // Firestore에서 'users' 컬렉션의 특정 사용자 문서의 'favorites' 서브컬렉션을 가져옴
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    // 가져온 문서들을 리스트로 변환하여 반환
    return querySnapshot.docs
        .map((doc) => {
              'id': doc.id, // 문서 ID를 포함
              ...doc.data() as Map<String, dynamic>, // 문서 데이터를 Map으로 변환하여 포함
            })
        .toList();
  }

  // Firestore에서 즐겨찾기 항목 제거
  Future<void> removeFavorite(String userId, String favoriteId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(favoriteId)
        .delete();
  }
}
