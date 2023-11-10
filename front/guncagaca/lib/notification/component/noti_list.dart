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
    MyAlertListFromAPI();
  }

  String baseUrl = dotenv.env['BASE_URL']!;
  Dio dio = DioClient.getInstance();

  Future<void> MyAlertListFromAPI() async {
    final String apiUrl = "$baseUrl/api/alert/history";

    final response = await dio.get(
        apiUrl,
        options: Options(
            headers: {
              'Authorization': "Bearer $token",
            }
        ),
    );
    print("response ${response.data}");
    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      notifications = List<Map<String, dynamic>>.from(jsonData);
      print(notifications);
      setState(() {});
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }

  Future<void> DeleteAlertFromAPI(int alertId) async {
    final String apiUrl = "$baseUrl/api/alert/history/$alertId";

    final response = await dio.delete(
      apiUrl,
      options: Options(
          headers: {
            'Authorization': "Bearer $token",
          }
      ),
        queryParameters: {
          'alertId': alertId
        }

    );

    if (response.statusCode == 200) {
      print("삭제 성공");
      setState(() {
        MyAlertListFromAPI();
      });
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }


  @override
  Widget build(BuildContext context) {
    print('All points: ${notifications}');

    return notifications.isEmpty
        ? Center(
      child: Text(
        "알림함이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: notifications.length + 1, // 한 개를 추가합니다.
      itemBuilder: (BuildContext context, int index) {
        if (index == notifications.length) {
          return SizedBox(height: 20); // 마지막 아이템일 때 공간을 추가합니다.
        }

        return Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            contentPadding:
            EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notifications[index]['title'],
                  style: TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  notifications[index]['body'],
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                DeleteAlertFromAPI(notifications[index]['id']);
              },
              child: Icon(Icons.close),
            ),
            onTap: () {
              // 알림을 눌렀을 때의 동작을 추가하세요.
            },
          ),
        );
      },
    );
  }
}

