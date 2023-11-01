import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';

import '../kakao/main_view_model.dart';


class PasswordPage extends StatefulWidget {

  final MainViewModel mainViewModel;

  const PasswordPage ({required this.mainViewModel});

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
        child: CustomAppbar(title: "비밀번호 변경", imagePath: null,)
      ),
      body:SingleChildScrollView(
        child: Column(
        children: [
          Container(
            color: Color(0xff9B5748),
            height: 0,
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

