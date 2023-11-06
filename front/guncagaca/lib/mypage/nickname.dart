import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guncagaca/common/view/custom_appbar.dart';

import '../common/layout/default_layout.dart';
import '../common/utils/dio_client.dart';
import '../common/view/root_tab.dart';
import '../kakao/main_view_model.dart';



class NicknamePage extends StatefulWidget {
  final MainViewModel mainViewModel;
  final String nickName;

  const NicknamePage ({required this.mainViewModel,
    required this.nickName});

  @override
  _NicknameState createState() => _NicknameState();
}

class _NicknameState extends State<NicknamePage> {
  String changeNickname = "회원";

  @override
  void initState() {
    super.initState();
    // changeNicknameFromAPI();
  }

  Dio dio = DioClient.getInstance();

  Future<void> changeNicknameFromAPI() async {
    final email = widget.mainViewModel.user?.kakaoAccount?.email;

    if (email != null) {
      try {
        Response response = await dio.put(
          "http://k9d102.p.ssafy.io:8081/api/member/mypage/change-nickname",
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json',
              'email': email.toString(),
            },
          ),
          queryParameters: {
            'nickname': changeNickname.toString(),
          },
        );

        if (response.statusCode == 200) {
          setState(() {});
          print("변경완료");
          print(changeNickname);
          Fluttertoast.showToast(
            msg: "변경 완료",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else {
          print('데이터 로드 실패, 상태 코드: ${response.statusCode}');
          Fluttertoast.showToast(
            msg: "데이터 로드 실패",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } catch (e) {
        print(email);
        print(changeNickname);
        print('에러: $e');
      }
    } else {
      print('이메일이 없습니다.');
    }
  }

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
      child : Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
            child: CustomAppbar(title: '닉네임 변경', imagePath: null,)
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xff9B5748),
                height: 0.0,
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
                          onChanged: (value) {
                            setState(() {
                              changeNickname = value;
                            });
                          },
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
                  onTap: () async{
                    await changeNicknameFromAPI();
                    print("닉네임 변경 완료");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DefaultLayout(
                        child: RootTab(mainViewModel: widget.mainViewModel, initialIndex: 2,),
                        mainViewModel: widget.mainViewModel,
                      )),
                    );
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

