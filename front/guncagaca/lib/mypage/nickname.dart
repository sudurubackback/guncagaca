import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NicknamePage extends StatefulWidget {
  @override
  _NicknameState createState() => _NicknameState();
}

class _NicknameState extends State<NicknamePage> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 밑 줄 제거
          automaticallyImplyLeading: false, // leading 영역을 자동으로 생성하지 않도록 설정
          flexibleSpace: Center(
            child: Row(
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
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.14, top: 20.0),
                  child: const Center(
                    child: Text(
                    '닉네임 변경',
                    style: TextStyle(color: Colors.black, fontSize: 29.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
        children: [
          Container(
            color: Color(0xff9B5748),
            height: 2.0,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.only(left: 30.0, right: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff9B5748),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '새로운 닉네임을 입력하세요'
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.08,
            margin: const EdgeInsets.only(top: 20.0,),
            padding: EdgeInsets.only(left: 30.0, right: 50.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff9B5748),
                width: 2.0,
              ),
              color: Color(0xff9B5748),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () {
                print("닉네임 변경 완료");
                Navigator.pop(context);
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '확인',
                      style: TextStyle(fontSize: 20,
                          color: Color(0xffffffff)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

}

