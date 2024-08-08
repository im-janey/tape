import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/favorite_button.dart'; // 즐겨찾기 버튼 컴포넌트 가져오기

// 즐겨찾기 화면을 나타내는 Stateless 위젯
class Favorite extends StatelessWidget {
  final String userId; // 사용자 ID를 저장하는 변수

  const Favorite({super.key, required this.userId}); // 생성자에서 userId를 초기화

  // Firestore에서 즐겨찾기 가게 목록을 가져오는 함수
  Future<List<Map<String, dynamic>>> getFavoriteStores(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users') // 'users' 컬렉션에서
        .where('userId', isEqualTo: userId) // userId가 일치하는 문서들을 가져옴
        .get();

    // 문서 데이터를 리스트로 변환하여 반환
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('찜'), // 앱바 제목 설정
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 자식 위젯들을 균등하게 배치
            children: const [
              Option(
                imageUrl: 'assets/fav1.png', // 이미지 경로
                name: '오뜨로 성수', // 가게 이름
                category: '식당', // 가게 카테고리
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getFavoriteStores(userId), // 즐겨찾기 가게 목록을 가져오는 Future
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // 로딩 인디케이터 표시
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}')); // 에러 메시지 표시
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(' ')); // 데이터가 없을 때 메시지 표시
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length, // 리스트 아이템 개수
                    itemBuilder: (context, index) {
                      var store = snapshot.data![index]; // 각 가게 데이터
                      return ListTile(
                        title: Text(store['name']), // 가게 이름 표시
                        subtitle: Text(store['category']), // 가게 카테고리 표시
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

// 옵션을 나타내는 Stateless 위젯
class Option extends StatelessWidget {
  final String imageUrl; // 이미지 경로
  final String name; // 가게 이름
  final String category; // 가게 카테고리

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
            Image.asset(imageUrl, width: 150, height: 150), // 이미지 표시
            Positioned(
              bottom: 3,
              right: 3,
              child: FavoriteButton(name: name), // 즐겨찾기 버튼
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 정렬
          children: [
            Text(name,
                style:
                    TextStyle(fontSize: 20, color: Colors.black)), // 가게 이름 텍스트
            Text(category,
                style:
                    TextStyle(fontSize: 16, color: Colors.grey)), // 가게 카테고리 텍스트
          ],
        ),
      ],
    );
  }
}
