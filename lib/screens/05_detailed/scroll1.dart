import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Scroll1 extends StatefulWidget {
  const Scroll1({super.key});

  @override
  State<Scroll1> createState() => _Scroll1State();
}

class _Scroll1State extends State<Scroll1> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    fetchImages(); // 이미지 URL 가져오기
  }

  Future<void> fetchImages() async {
    try {
      String folderPath = 'info_banner/'; // Firebase Storage의 폴더 경로
      final ListResult result =
          await FirebaseStorage.instance.ref(folderPath).listAll();

      List<String> urls = [];
      for (var ref in result.items) {
        String url = await ref.getDownloadURL(); // 각 이미지의 URL 가져오기
        urls.add(url);
      }

      setState(() {
        imageUrls = urls; // 가져온 URL 리스트로 상태 업데이트
      });
    } catch (e) {
      print('Error fetching images: $e');
      setState(() {
        imageUrls = []; // 에러 발생 시 빈 리스트로 초기화
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          SizedBox(width: 50),
          SizedBox(
            height: 200,
            width: 340,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  imageUrls.isNotEmpty ? imageUrls.length : 1, // 이미지가 없으면 1로 설정
              itemBuilder: (context, index) {
                // 이미지가 없을 경우 로딩 인디케이터 표시
                if (imageUrls.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  width: 200,
                  height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      imageUrls[index], // 동적으로 URL 사용
                      fit: BoxFit.cover, // 이미지 맞춤
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
