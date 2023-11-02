import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget{
  final String title;
  final String? imagePath;

  CustomAppbar({
    required this.title,
    this.imagePath,
});

  @override
  Widget build(BuildContext context){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, // 밑 줄 제거
      automaticallyImplyLeading: false, // leading 영역을 자동으로 생성하지 않도록 설정
      flexibleSpace: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Color(0xff000000),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only( top: 20.0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 29.0),
                    textAlign: TextAlign.center,
                  ),
                  if (imagePath != null) // imagePath가 null이 아닌 경우에만 이미지 표시
                    SizedBox(width: 10.0), // 이미지와 텍스트 사이 간격 조절
                  if (imagePath != null) // imagePath가 null이 아닌 경우에만 이미지 표시
                    Image.asset(
                      imagePath!, // 이미지 파일 경로 설정
                      width: 30.0, // 이미지 너비 설정
                      height: 30.0, // 이미지 높이 설정
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Opacity(
                opacity: 0.0, // 아이콘을 투명하게 만듭니다.
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Color(0xff000000),
                  onPressed: () {
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: Container(
          color: Color(0xff9B5748),
          height: 2.0,
        ),
      ),
    );
  }
}