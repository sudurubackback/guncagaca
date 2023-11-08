import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/const/colors.dart';
import '../../common/utils/dio_client.dart';
import '../../common/utils/oauth_token_manager.dart';

class NotiList extends StatefulWidget {


  @override
  _NotiListState createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  final token = TokenManager().token;
  List<Map<String, dynamic>> notifications = [];
  @override
  void initState() {
    super.initState();
    test();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();


  Future<void> test() async {
    final String apiUrl = "http://k9d102.p.ssafy.io:8082/v1/fcm/sendMember";

    final response = await dio.post(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        ),
        data: {
          "memberId": 5,
          "title": "string",
          "body": "string",
          "imageUrl": "string",
          "productCode": "string"
        }
    );
    print(response.data);
    if (response.statusCode == 200) {
          print("성공");
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return notifications.isEmpty
        ? Center(
      child: Text(
        "알림이 없습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: notifications.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == notifications.length) {
          return SizedBox(height: 20);
        }
        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9B5748),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),

                          ),
                        ),
                        SizedBox(width: 10),

                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 25),
                        SizedBox(width: 10),
                       ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.chat, color: Colors.grey, size: 20),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xffF8E9D7),
                          border: Border.all(color: Color(0xff9B5748), width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [

                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 3),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {

            },
          ),
        );
      },
    );
  }
}
