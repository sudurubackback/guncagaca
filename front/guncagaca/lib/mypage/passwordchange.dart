import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PasswordPage extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<PasswordPage> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xfff8e9d7),
      statusBarIconBrightness: Brightness.dark,
    ));

    return GestureDetector(
        onTap: () {
      FocusScope.of(context).unfocus();
    },
    child :Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
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
                  child: Center(
                    child: Text(
                    '비밀번호 변경',
                    style: TextStyle(color: Colors.black, fontSize: 29.0),
                    textAlign: TextAlign.center,
                  ),
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: _isObscured, // 상태 변수에 따라 가려지거나 나타남
                      enableSuggestions: _isObscured,
                      autocorrect: _isObscured,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '현재 비밀번호를 입력하세요'
                      ),
                    ),

                  ),
                  IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured; // 토글
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20.0,),
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: _isObscured, // 상태 변수에 따라 가려지거나 나타남
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '새로운 비밀번호를 입력하세요'
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20.0,),
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      obscureText: _isObscured, // 상태 변수에 따라 가려지거나 나타남
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '다시 한 번 입력하세요'
                      ),
                      style: TextStyle(color: Colors.black),
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
                print("비밀번호변경 완료");
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
    ),
    );
  }

}

