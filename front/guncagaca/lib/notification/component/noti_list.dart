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
  bool loading = true;
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

    if (response.statusCode == 200) {
      List<dynamic> jsonData = response.data;
      setState(() {
        notifications = List<Map<String, dynamic>>.from(jsonData);
        loading = false;
      });
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
      setState(() {
        MyAlertListFromAPI();
      });
    } else {
      throw Exception("Failed to fetch menus.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : notifications.isEmpty
        ? Center(
          child: Text(
          "알림함이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: notifications.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == notifications.length) {
          return SizedBox(height: 20);
        }
        final notification = notifications[index];

        return Dismissible(
          key: Key(notification['id'].toString()),
          // 고유한 key 제공
          direction: DismissDirection.endToStart,
          // 오른쪽에서 왼쪽으로 스와이프
          onDismissed: (direction) {
            // 삭제 로직 실행
            setState(() {
              notifications.removeAt(index);
            });
            DeleteAlertFromAPI(notification['id']);
          },
          background: Container(
            color: Colors.redAccent,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.delete, color: Colors.white),
                  Text('삭제', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          child: Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['title'],
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    notification['body'],
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    notification['createTime'] ?? '시간 정보 없음',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
              onTap: () {
                // 알림을 눌렀을 때의 동작을 추가하세요.
              },
            ),
          ),
        );
      },
    );
  }
}
