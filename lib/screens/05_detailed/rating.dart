import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();

  // 사용자가 선택한 별점
  int _Rating = 0;
  int _rating2 = 0;
  int _rating3 = 0;
  int _rating4 = 0;

  // 별점을 제출하는 함수
  void _submitRating() {
    String reviewText = _textController.text.trim();
    // 별점이 0보다 큰 경우에만 제출
    if (_Rating > 0 && _rating2 > 0 && _rating3 > 0 && _rating4 > 0) {
      // Firestore의 'ratings' 컬렉션에 별점 추가
      _firestore.collection('ratings').add({
        'rating': _Rating,
        'wheelchair_access': _rating2,
        'wheelchair_seating': _rating3,
        'kindness': _rating4,
        'review': reviewText, // 선택한 별점
        'timestamp': FieldValue.serverTimestamp(), // 서버 타임스탬프
      }).then((_) {
        // 성공적으로 저장된 경우
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('리뷰가 저장되었습니다!')), // 사용자에게 알림
        );
        // 상태를 초기화하여 별점 선택 초기화
        setState(() {
          _Rating = 0;
          _rating2 = 0;
          _rating3 = 0;
          _rating4 = 0;
          _textController.clear();
          // 별점 초기화
        });
      }).catchError((error) {
        // 오류 발생 시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류 발생: $error')), // 오류 메시지 표시
        );
      });
    } else {
      // 별점을 선택하지 않은 경우
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 항목의 별점을 선택하세요!')), // 별점 선택 요청
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 전체 여백 설정
        child: Column(
          children: [
            Text(
              '별점을 선택하세요:',
              style: TextStyle(fontSize: 20), // 텍스트 스타일
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _Rating
                        ? Icons.star
                        : Icons.star_border, // 선택된 별점에 따라 아이콘 변경
                    color: Color(0xff4863E0), // 별점 색상
                  ),
                  iconSize: 40,
                  onPressed: () {
                    // 별점을 선택할 때
                    setState(() {
                      _Rating = index + 1; // 선택한 별점 저장
                    });
                  },
                );
              }),
            ), //전체 별점
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '휠체어 출입',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating2
                                ? Icons.star
                                : Icons.star_border, // 선택된 별점에 따라 아이콘 변경
                            color: Color(0xff4863E0), // 별점 색상
                          ),
                          iconSize: 30,
                          onPressed: () {
                            // 별점을 선택할 때
                            setState(() {
                              _rating2 = index + 1; // 선택한 별점 저장
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '휠체어 좌석',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating3
                                ? Icons.star
                                : Icons.star_border, // 선택된 별점에 따라 아이콘 변경
                            color: Color(0xff4863E0), // 별점 색상
                          ),
                          iconSize: 30,
                          onPressed: () {
                            // 별점을 선택할 때
                            setState(() {
                              _rating3 = index + 1; // 선택한 별점 저장
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '친절도',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _rating4
                                ? Icons.star
                                : Icons.star_border, // 선택된 별점에 따라 아이콘 변경
                            color: Color(0xff4863E0), // 별점 색상
                          ),
                          iconSize: 30,
                          onPressed: () {
                            // 별점을 선택할 때
                            setState(() {
                              _rating4 = index + 1; // 선택한 별점 저장
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ), //휠체어 출입 별점

            Container(
              width: double.infinity,
              height: 150,
              child: TextField(
                controller: _textController, // 텍스트 필드 컨트롤러
                decoration: InputDecoration(
                  hintText: '이곳에 다녀온 경험을 자세히 공유해주세요\n\n\n', // 레이블 텍스트
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)), // 테두리 스타일
                ),
                maxLines: null,
              ),
            ),

            SizedBox(height: 50), // 텍스트 필드와 버튼 사이의 여백
            ElevatedButton(
              onPressed: () {
                _submitRating(); // 평점 제출 함수 호출
                Navigator.pop(context); // 현재 페이지를 닫음
              },
              child: Text('제출'), // 버튼 텍스트
            )
          ],
        ),
      ),
    );
  }
}
