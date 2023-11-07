import 'package:flutter/material.dart';

import '../../common/const/colors.dart';

class NotiList extends StatefulWidget {
  final List<Map<String, dynamic>> notifications;

  NotiList({required this.notifications});

  @override
  _NotiListState createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  void _removeNotification(int index) {
    setState(() {
      widget.notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('All points: ${widget.notifications}');

    return widget.notifications.isEmpty
        ? Center(
      child: Text(
        "알림함이 비었습니다.",
        style: TextStyle(fontSize: 18.0),
      ),
    )
        : ListView.builder(
      itemCount: widget.notifications.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.notifications.length) {
          return SizedBox(height: 20);
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
                  widget.notifications[index]['title'],
                  style: TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  widget.notifications[index]['message'],
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                _removeNotification(index);
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
