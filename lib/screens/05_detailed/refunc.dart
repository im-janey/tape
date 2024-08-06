import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Refunc extends StatelessWidget {
  const Refunc({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ratings')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('오류가 발생했습니다'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var reviewDoc = snapshot.data!.docs[index];
            var reviewData = reviewDoc.data() as Map<String, dynamic>?;

            if (reviewData == null) {
              return ListTile(title: Text('리뷰 데이터를 불러올 수 없습니다.'));
            }

            return ListTile(
              leading: SizedBox(),
              title: Row(
                children: [
                  Text('전체 평가: '),
                  Row(
                    children: List.generate(5, (starIndex) {
                      int rating = reviewData['rating'] as int? ?? 0;
                      return Icon(
                        starIndex < rating ? Icons.star : Icons.star_border,
                        color: Color(0xff4863E0),
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('휠체어 출입: ${reviewData['wheelchair_access'] ?? 'N/A'}'),
                  Text('휠체어 좌석: ${reviewData['wheelchair_seating'] ?? 'N/A'}'),
                  Text('친절도: ${reviewData['kindness'] ?? 'N/A'}'),
                  SizedBox(height: 8),
                  Text(reviewData['review'] as String? ?? '리뷰 내용 없음'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
