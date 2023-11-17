import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
import 'package:guncagaca/common/layout/custom_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/dio_client.dart';
import '../../../common/utils/oauth_token_manager.dart';
import '../../../common/view/root_tab.dart';
import '../../../kakao/main_view_model.dart';



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
  final token = TokenManager().token;

  @override
  void initState() {
    super.initState();
  }

  static Future<String?> getEmailFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<void> changeNicknameFromAPI() async {
    String? email = await getEmailFromPreferences();

    print(email);
    if (email != null) {
      try {
        Response response = await dio.put(
          "$baseUrl/api/member/mypage/change-nickname",
          options: Options(
              headers: {
                'Authorization': "Bearer $token",
              }
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
      statusBarColor: BACK_COLOR,
      statusBarIconBrightness: Brightness.dark,
    ));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child : Scaffold(
        appBar: CustomAppBar(title: '닉네임 변경', mainViewModel: widget.mainViewModel,),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: PRIMARY_COLOR,
                height: 0.0,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.08,
                padding: EdgeInsets.only(left: 30.0, right: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: PRIMARY_COLOR,
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
                          maxLength: 8,
                          textAlignVertical: TextAlignVertical.top,
                          onChanged: (value) {
                            setState(() {
                              changeNickname = value;
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '새로운 닉네임을 입력하세요',
                            contentPadding: EdgeInsets.only(left: 10.0, right: 10.0), // 텍스트 필드 내부의 패딩을 조정합니다.
                            counter: Offstage(),
                          ),
                          textInputAction: TextInputAction.done,
                          buildCounter: (BuildContext context, { int? currentLength, bool? isFocused, int? maxLength }) {
                            return Positioned(
                              right: 0,
                              bottom: 0,
                              child: Text(
                                '${currentLength ?? 0}/${maxLength ?? 8}', // 현재 글자 수 / 최대 글자 수.
                                style: TextStyle(color: PRIMARY_COLOR),
                              ),
                            );
                          },
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
                    color: PRIMARY_COLOR,
                    width: 2.0,
                  ),
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () async{
                    await changeNicknameFromAPI();
                    print("닉네임 변경 완료");
                    Get.to(() => DefaultLayout(
                        child: RootTab(mainViewModel: widget.mainViewModel, initialIndex: 2,),
                        mainViewModel: widget.mainViewModel,
                      )
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

