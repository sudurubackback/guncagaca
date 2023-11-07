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
      elevation: 0,
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
                  if (imagePath != null)
                    SizedBox(width: 10.0),
                  if (imagePath != null)
                    Image.asset(
                      imagePath!,
                      width: 30.0,
                      height: 30.0,
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Opacity(
                opacity: 0.0,
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